class CalendarPointsController < ApplicationController
  def index
    @calendar_points = Point.all
  end
end
