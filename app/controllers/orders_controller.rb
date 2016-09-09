class OrdersController < ApplicationController
  include CalendarsHelper
  load_and_authorize_resource
  before_action :has_point?, only: :index

  def index
    @products = Product.all
    @point = Point.find_by(id: params[:point_id])

    date = Time.now
    orders = @point.orders.all_day(date)
    @sum_orders = sum_orders orders
  end

  private

  def has_point?
    if params[:point_id].blank?
      redirect_to root_path
    end
  end

end
