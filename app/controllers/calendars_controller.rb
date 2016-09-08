class CalendarsController < ApplicationController
  before_action :has_access?
  before_action :has_point?

  def index
    @point = Point.find_by(id: params[:point])
    @orders = @point.orders
  end

  def show
    @point = Point.find_by(id: params[:point])
    @date = params[:id].to_date
    @orders = @point.orders.all_day(date)
  end

  private

  def has_access?
    unless current_user.has_any_role? :barman, :admin
      redirect_to root_path
    end
  end

  def has_point?
    if params[:point].blank?
      redirect_to root_path
    end
  end
end
