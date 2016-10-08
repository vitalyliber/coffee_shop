class BarmansController < ApplicationController

  before_action :find_barman, only: [:show, :destroy, :self_destroy]
  before_action :point_admin_protect, except: [:self_destroy]

  def index
    @barmans = User.with_role(:barman, @current_point)
  end

  def show
  end

  def new
    barman_invite = BarmanInvite.new(point: @current_point)
    @barman_code = barman_invite.generate_code

    if barman_invite.save
      flash.now[:success] = t :key_successfully_generated
    else
      flash.now[:error] = t :something_went_wrong
    end

  end

  def destroy
    @barman.remove_role :barman, @current_point

    unless @barman.has_role? :barman, @current_point
      flash[:success] = t :barman_successfully_removed_from_sales_point
    else
      flash[:error] = t :something_went_wrong
    end

    redirect_to point_barmans_path(@current_point)
  end

  def self_destroy
    @point = Point.find_by(id: params[:point_id])

    @barman.remove_role :barman, @point

    unless @barman.has_role? :barman, @point
      flash[:success] = t :you_successfully_removed_from_sales_point
      point_set_to_default
    else
      flash[:error] = t :something_went_wrong
    end

    redirect_to points_path(set: 'point', mode: :edit)
  end

  private

  def find_barman
    @barman = User.find(params[:id])
  end

end
