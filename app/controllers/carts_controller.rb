class CartsController < ApplicationController
  before_action :initialize_cart

  def show
  end

  def add
    product = Product.find(params[:id])
    quantity = params[:quantity].to_i

    if @cart[product.id.to_s].nil?
      @cart[product.id.to_s] = { 'quantity' => quantity }
    else
      @cart[product.id.to_s]['quantity'] += 1
    end

    save_cart
    redirect_to cart_path, notice: 'Product added to cart.'
  end

  def decrease
    product_id = params[:id]
    if @cart[product_id] && @cart[product_id]['quantity'] > 1
      @cart[product_id]['quantity'] -= 1
    else
      @cart.delete(product_id)
    end

    save_cart
    redirect_to cart_path, notice: 'Product quantity decreased.'
  end

  def remove
    @cart.delete(params[:id])
    save_cart
    redirect_to cart_path, notice: 'Product removed from cart.'
  end

  private

  def initialize_cart
    @cart = session[:cart] || {}
  end

  def save_cart
    session[:cart] = @cart
  end
end
