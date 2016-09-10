class ProductsController < ApplicationController
  def index
    @point = Point.find_by(id: params[:point_id])
    @products = ProductList.find_by(point: @point).products
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end
end
