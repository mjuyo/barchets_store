class ProductsController < ApplicationController
  before_action :set_product, only: %i[show add_to_cart remove_from_cart]

  def index
    @categories = Category.all
    @products = Product.all

    if params[:search].present?
      @products = @products.where('products.name LIKE ? OR products.description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @products.joins(:categories).where(categories: { id: params[:category_id] })
    end

    case params[:filter]
    when 'on_sale'
      @products = @products.on_sale
    when 'new'
      @products = @products.new_products
    when 'recently_updated'
      @products = @products.recently_updated
    end

    @products = @products.page(params[:page]).per(12)
  end

  def category
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(12)
    render :index
  end

  def show
    @product = Product.find(params[:id])
    @category = @product.categories.first
  end

  def add_to_cart
    @cart = session[:cart] ||= {}
    product_id = params[:id].to_s
    quantity = params[:quantity].to_i

    if @cart[product_id]
      @cart[product_id]['quantity'] += quantity
    else
      @cart[product_id] = { 'quantity' => quantity }
    end

    session[:cart] = @cart
    redirect_to cart_path, notice: "#{@product.name} has been added to your cart."
  end

  def remove_from_cart
    @cart = session[:cart] ||= {}
    product_id = params[:id].to_s

    @cart.delete(product_id)
    session[:cart] = @cart
    redirect_to cart_path, notice: "#{@product.name} has been removed from your cart."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
