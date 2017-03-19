class BarmansController < ApplicationController

  before_action :find_barman, only: [:show, :destroy, :self_destroy]
  before_action :point_admin_protect, except: [:self_destroy, :activate]

  def index
    @barmans = User.with_role(:barman, @current_point)
  end

  def show
  end

  def new
    barman_invite = BarmanInvite.find_or_create_by(point: @current_point)
    @barman_link = "http://#{request.host_with_port}/barmans/#{barman_invite.code}/activate"

    unless barman_invite.present?
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

  def activate
    if current_user.blank?
      flash[:success] = t :barmen_need_auth
      cookies[:barman_code] = params[:id]
      return redirect_to root_path
    end

    if params[:id].blank?
      flash[:error] = t :type_code_sales_point

      return redirect_to points_path(@current_point)
    end

    barman_invite = BarmanInvite.find_by(code: params[:id])

    if barman_invite.present?
      point = barman_invite.point

      if current_user.has_role? :admin, point
        flash[:error] = t :you_already_are_owner

        return redirect_to points_path(@current_point)
      end

      current_user.add_role :barman, point

      flash[:success] = t(:sales_point_successfully_activated, title: point.title)

      barman_invite.delete
    else
      flash[:error] = t :sales_point_not_found_by_code

      return redirect_to points_path(@current_point)
    end

    common_tuning = CommonTuning.find_by(user: current_user)
    common_tuning.update(current_point: point)

    redirect_to points_path(@current_point)
  end

  private

  def find_barman
    @barman = User.find(params[:id])
  end

end
