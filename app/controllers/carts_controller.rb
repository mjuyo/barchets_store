class CartsController < ApplicationController
  before_action :initialize_cart

  def show
  end

  def add_to_cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if @cart[product.id.to_s].nil?
      @cart[product.id.to_s] = { 'quantity' => quantity }
    else
      @cart[product.id.to_s]['quantity'] += quantity 
    end

    save_cart
    redirect_to cart_path, notice: 'Product added to cart.'
  end

  def remove_from_cart
    @cart.delete(params[:product_id])
    save_cart
    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  def update_cart
    @cart[params[:product_id]]['quantity'] = params[:quantity].to_i
    save_cart
    redirect_to cart_path, notice: 'Cart updated.'
  end

  private
  def initialize_cart
    @cart = session[:cart] || {}
  end

  def save_cart
    session[:cart] = @cart
  end
end
