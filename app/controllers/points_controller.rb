class PointsController < ApplicationController
  before_action :find_point, only: [:show, :start_sales]

  def index
    @admin_points = Point.with_role(:admin, current_user)
    @barman_points = Point.with_role(:barman, current_user)
  end

  def show
    @day_sale = DaySale.find_by(status: :opened, user: current_user, point: @point)

    if @day_sale.blank?
      @last_day_sale= DaySale.where(status: :closed, user: current_user, point: @point).last
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

  private

  def find_point
    @point = Point.find_by(id: params[:id])
  end
end