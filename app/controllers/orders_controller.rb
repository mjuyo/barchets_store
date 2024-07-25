class OrdersController < ApplicationController
  before_action :initialize_cart
  before_action :authenticate_customer!, only: [:new, :create]
  
  def new
    @order = Order.new
  end

  def create
    logger.debug "Order Params: #{order_params.inspect}"
    logger.debug "Cart: #{@cart.inspect}"

    @order = current_customer.orders.new(order_params)
    @order.order_date = Time.zone.now
    @order.status = 'pending'
    @order.total_price = calculate_total_price
    @order.total_tax = calculate_total_tax(@order.total_price)

    if @order.save
      @cart.each do |product_id, details|
        product = Product.find(product_id)
        @order.order_products.create!(
          product: product,
          quantity: details['quantity'],
          price: product.price * details['quantity']
        )
      end
      
      session[:cart] = {}
      logger.debug "Order successfully saved: #{@order.inspect}"
      redirect_to order_path(@order), notice: 'Order placed succesfully.'
    else
      logger.debug "Order not saved: #{@order.errors.full_messages.inspect}"
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @province = @order.province
    @pst = calculate_individual_tax(@order.total_price, @province.pst_rate)
    @gst = calculate_individual_tax(@order.total_price, @province.gst_rate)
    @hst = calculate_individual_tax(@order.total_price, @province.hst_rate)
    @qst = calculate_individual_tax(@order.total_price, @province.qst_rate)
  end

  private

  def order_params
    params.require(:order).permit(:order_date, :status, :total_price, :total_tax, :address, :province_id)
  end

  def initialize_cart
    @cart = session[:cart] || {}
  end

  def calculate_total_price
    @cart.sum { |product_id, details| Product.find(product_id).price * details['quantity'] }
  end

  def calculate_total_tax(total_price)
    province = Province.find(params[:order][:province_id])
    pst = (total_price * province.pst_rate / 100)
    gst = (total_price * province.gst_rate / 100)
    hst = (total_price * province.hst_rate / 100)
    qst = (total_price * province.qst_rate / 100)
    pst + gst + hst + qst
  end

  def calculate_individual_tax(total_price, tax_rate)
    (total_price * tax_rate / 100).round(2)
  end
end
