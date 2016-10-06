class ProductsController < ApplicationController
  before_action :find_point
  before_action :find_product, only: [:update, :edit, :destroy]
  before_action :point_admin_protect
  include ProductsHelper

  def index
    @products = ProductList.find_by(point: @point).products.order(title: :asc)
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
    @product.product_list = @point.product_list

    if @product.save
      flash[:success] = t :product_successfully_created
      redirect_to point_products_path(@point)
    else
      render :new
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t :product_successfully_destroyed
      redirect_to point_products_path(@point)
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :ml, :price, :meter)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end

  def find_point
    @point = Point.find_by(id: params[:point_id])

    point_protect
  end
end
