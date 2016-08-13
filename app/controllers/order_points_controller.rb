class OrderPointsController < ApplicationController
  def index
    @order_points = Point.all
  end
end
