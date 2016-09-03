class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :has_point?, only: :index

  def index
    @products = Product.all
    @point = Point.find_by(id: params[:point])
  end

  private

  def has_point?
    if params[:point].blank?
      redirect_to root_path
    end
  end

end
