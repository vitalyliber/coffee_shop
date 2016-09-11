class PointsController < ApplicationController
  include OrdersHelper

  before_action :find_point, only: [:show, :start_sales, :end_sales, :till]
  before_action :has_day_sale?, only: :till

  def index
    redirect_to point_path( Point.with_role(:admin, current_user).try(:first) )

    @admin_points = Point.with_role(:admin, current_user)
    @barman_points = Point.with_role(:barman, current_user)
  end

  def show
    @day_sale = DaySale.find_by(status: :opened, user: current_user, point: @point)

    if @day_sale.blank?
      @last_day_sale = DaySale.where(status: :closed, user: current_user, point: @point).last
    end
  end

  def start_sales
    @day_sale = DaySale.new(status: :opened, user: current_user, point: @point, start: Time.now)

    if @day_sale.save
      redirect_to point_path(@point)
    else
      render 'show'
    end
  end

  def end_sales
    day_sales = @point.day_sales.find_by(status: :opened, user: current_user)

    if day_sales.update(status: :closed, end: Time.now)
      redirect_to point_path(@point)
    end
  end

  def till
    @products = @point.product_list.products

    @day_sales = @point.day_sales.find_by(status: :opened, user: current_user)
    orders = @point.orders.current_sales(@day_sales.start)
    @sum_orders = sum_orders orders
  end

  private

  def find_point
    @point = Point.find_by(id: params[:id] || params[:point_id])
  end

  def has_day_sale?
    if @point.day_sales.find_by(status: :opened, user: current_user).blank?
      redirect_to root_path
    end
  end
end