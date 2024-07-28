class OrdersController < ApplicationController
  before_action :initialize_cart
  before_action :authenticate_customer!, only: [:new, :create]

  def new
    @order = Order.new
    @order_summary = calculate_order_summary
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def create
    puts params.inspect
    @order = current_customer.orders.new(order_params)
    @order.order_date = Time.zone.now
    @order.status = 'pending'
    @order.sub_total_price = calculate_sub_total_price
    @order.total_tax = calculate_total_tax(@order.sub_total_price)
    @order.total_price = @order.sub_total_price + @order.total_tax
    
  
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
      redirect_to order_path(@order), notice: 'Order placed successfully.'
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @province = @order.province
    @pst = calculate_individual_tax(@order.sub_total_price, @province.pst_rate)
    @gst = calculate_individual_tax(@order.sub_total_price, @province.gst_rate)
    @hst = calculate_individual_tax(@order.sub_total_price, @province.hst_rate)
    @qst = calculate_individual_tax(@order.sub_total_price, @province.qst_rate)
  end

  private

  def order_params
    params.require(:order).permit(:order_date, :status, :total_price, :total_tax, :address, :province_id)
  end

  def initialize_cart
    @cart = session[:cart] || {}
  end

  def calculate_sub_total_price
    @cart.sum { |product_id, details| Product.find(product_id).price * details['quantity'] }
  end

  def calculate_total_tax(sub_total_price)
    province = Province.find(params[:order][:province_id])
    pst = (sub_total_price * province.pst_rate / 100)
    gst = (sub_total_price * province.gst_rate / 100)
    hst = (sub_total_price * province.hst_rate / 100)
    qst = (sub_total_price * province.qst_rate / 100)
    pst + gst + hst + qst
  end

  def calculate_individual_tax(sub_total_price, tax_rate)
    (sub_total_price * tax_rate / 100).round(2)
  end

  def calculate_order_summary
    {
      subtotal: @cart.sum { |product_id, details| Product.find(product_id).price * details['quantity'] },
      shipping: 0,
      taxes: 'Applicable taxes will be calculated at checkout.'
    }
  end
end
