class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

    if params[:search].present?
      @products = @products.where('products.name LIKE ? OR products.description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:category_id].present?
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

    @products = @products.page(params[:page]).per(9)
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
