class ProductsController < ApplicationController
  before_action :find_point
  before_action :find_product, only: [:update, :edit]
  include ProductsHelper

  def index
    @products = ProductList.find_by(point: @point).products
  end

  def edit
  end

  def show
    redirect_to point_products_path(@point)
  end

  def update
    if @product.update(product_params)
      redirect_to point_products_path(@point)
    else
      render :edit
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to point_products_path(@point)
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :ml, :price)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end

  def find_point
    @point = Point.find_by(id: params[:point_id])
  end
end
