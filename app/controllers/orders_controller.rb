class OrdersController < ApplicationController
  before_action :find_point
  include OrdersHelper

  def index
    @day_sales = @point.day_sales.where(status: :closed, user: current_user).order(created_at: :desc)
  end

  def day_sales
    day_sale_id = params[:day_sale]

    if day_sale_id.present?
      @day_sales = @point.day_sales.find_by(id: day_sale_id)
    else
      @day_sales = @point.day_sales.find_by(status: :opened, user: current_user)
    end

    @orders = @day_sales.orders.current_sales(@day_sales.start).order(created_at: :desc)
  end

  private

  def find_point
    @point = Point.find_by(id: params[:point_id])
  end

end
