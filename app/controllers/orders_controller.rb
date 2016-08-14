class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :has_point?, only: :index

  def index
    @products = Product.all
    @point = Point.find_by(id: params[:point])
  end

  def show
  end

  def create
    @order = Order.create(order_params)
    repeat_products = JSON.parse(params[:repeat_products], symbolize_names: :true)

    params[:selected_products].each do |product|
      repeat_products.each do |repeat|
        if repeat[:id] == product.to_i
          repeat[:repeat].times do
            @order.products << Product.find_by_id(product)
          end
        end
      end
    end

    respond_to do |format|
      if @order.save
        format.json { render :show, status: :created, location: @order }
      else
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def order_params
      params.require(:order).permit(:title, :cost_price, :point_id)
    end

    def has_point?
      if params[:point].blank?
        redirect_to root_path
      end
    end
end
