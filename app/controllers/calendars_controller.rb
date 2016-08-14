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
    @orders = @point.orders.where(created_at: @date.beginning_of_day..@date.to_date.end_of_day)
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
