class ProductsController < ApplicationController
  def index
    @categories = Category.all # Ensure @categories is available for the view
    @products = Product.page(params[:page]).per(10)
    @products = @products.on_sale if params[:on_sale] == 'true'
    @products = @products.new_products if params[:new] == 'true'
  end

  def search
    @categories = Category.all # Ensure @categories is available for the view
    @products = Product.all
    if params[:keyword].present?
      keyword = params[:keyword]
      @products = @products.joins(:category).where("products.name LIKE ? OR products.description LIKE ? OR categories.name LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
    end
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end
    @products = @products.page(params[:page]).per(10)
    render :index
  end

  def show
    @product = Product.find(params[:id])
  end
end
