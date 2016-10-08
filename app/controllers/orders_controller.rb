class OrdersController < ApplicationController
  before_action :find_point
  before_action :point_admin_protect
  include OrdersHelper

  def index
    users = User.with_role(:admin, @point).pluck(:id)
    users += User.with_role(:barman, @point).pluck(:id) if users.present?

    @day_sales = @point.day_sales.where(status: :closed, user_id: users).order(created_at: :desc).page(params[:page]).per(20)
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
