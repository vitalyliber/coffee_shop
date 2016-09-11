class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :find_point
  include OrdersHelper

  def till
  end

  def day_sales
    @day_sales = @point.day_sales.find_by(status: :opened, user: current_user)

    @orders = @day_sales.orders.current_sales(@day_sales.start).order(created_at: :desc)
  end

  private

  def find_point
    @point = Point.find_by(id: params[:point_id])
  end

end
