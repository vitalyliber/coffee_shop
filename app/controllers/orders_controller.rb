class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :has_point?, only: :index
  before_action :find_point
  before_action :has_day_sale?, only: :index
  include OrdersHelper

  def index
    @products = @point.product_list.products

    @day_sales = @point.day_sales.find_by(status: :opened, user: current_user)
    orders = @point.orders.current_sales(@day_sales.start)
    @sum_orders = sum_orders orders
  end

  def day_sales
    @day_sales = @point.day_sales.find_by(status: :opened, user: current_user)

    @orders = @point.orders.current_sales(@day_sales.start).order(created_at: :desc)
  end

  private

  def has_point?
    if params[:point_id].blank?
      redirect_to root_path
    end
  end

  def has_day_sale?
    if @point.day_sales.find_by(status: :opened, user: current_user).blank?
      redirect_to root_path
    end
  end

  def find_point
    @point = Point.find_by(id: params[:point_id])
  end

end
