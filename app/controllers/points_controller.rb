class PointsController < ApplicationController
  def index
    @admin_points = Point.with_role(:admin, current_user)
    @barman_points = Point.with_role(:barman, current_user)
  end

  def show
    @point = Point.find_by id: params[:id]
  end
end