class OrdersController < ApplicationController
  before_action :initialize_cart
  before_action :authenticate_customer!, only: [:new, :create]
  
  def new
    @order = Order.new
  end

  def create
    @order = current_customer.orders.new(order_params)
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
      redirect_to root_path, notice: 'Order placed succesfully.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_date, :status, :total_price, :total_tax)
  end

  def initialize_cart
    @cart = session[:cart] || {}
  end
end
