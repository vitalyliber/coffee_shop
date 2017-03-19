class HomesController < ApplicationController
  def index
    redirect_to point_path(@current_point) if current_user.present?
  end
end
