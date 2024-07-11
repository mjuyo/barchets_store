class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(9)
  end

  def category
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(9)
    render :index
  end

  def show
    @product = Product.find(params[:id])
  end
end
