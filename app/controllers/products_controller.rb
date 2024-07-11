class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def category
    @category = Category.find(params[:id])
    @products = @category.products
    render :index
  end

  def show
    @product = Product.find(params[:id])
  end
end
