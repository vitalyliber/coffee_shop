class PointsController < ApplicationController
  include OrdersHelper

  before_action :find_point, only: [:show, :start_sales, :end_sales, :till, :set, :edit, :update]
  before_action :has_day_sale?, only: :till

  def index
    if params[:set].blank?

      redirect_to point_path(@current_point)
    end

    @admin_points = Point.with_role(:admin, current_user)
    @barman_points = Point.with_role(:barman, current_user)
  end

  def create
    point = Point.new(title: params[:name])

    if point.save
      flash[:success] = t :point_successfully_created
      current_user.add_role :admin, point
      product_list = ProductList.create(point: point)
      Product.create(product_list: product_list, title: 'Coffee Cup', price: 140, ml: 400, meter: :ml)
      redirect_to points_path(set: :true)
    else
      flash.now[:error] = t :please_type_a_point_name
      render :new
    end
  end

  def show
    @day_sale = DaySale.find_by(status: :opened, user: current_user, point: @point)

    if @day_sale.blank?
      @last_day_sale = DaySale.where(status: :closed, user: current_user, point: @point).last
    end
  end

  def edit
  end

  def update
    if @point.update(title: params[:name])
      flash[:success] = t :point_successfully_updated
      redirect_to points_path(set: :true)
    else
      flash.now[:error] = t :please_type_a_point_name
      render :edit
    end
  end

  def set
    CommonTuning.find_by(user: current_user).update(current_point: @point)
    flash[:success] = t(:you_have_chosen_point, point: @point.title)

    redirect_to point_path(@point)
  end

  def start_sales
    @day_sale = DaySale.new(status: :opened, user: current_user, point: @point, start: Time.now)

    if @day_sale.save
      flash[:success] = t :day_sales_successfully_opened

      redirect_to point_path(@point)
    else
      render 'show'
    end
  end

  def end_sales
    day_sales = @point.day_sales.find_by(status: :opened, user: current_user)

    if day_sales.update(status: :closed, end: Time.now)
      flash[:success] = t :day_sales_successfully_closed

      redirect_to point_path(@point)
    end
  end

  def till
    @products = @point.product_list.products

    @day_sales = @point.day_sales.find_by(status: :opened, user: current_user)
    orders = @point.orders.current_sales(@day_sales.start).where(day_sale: @day_sales)
    @sum_orders = sum_orders orders
  end

  def activate
  end

  def activate_process
    if params[:code].blank?
      flash[:error] = t :type_code_sales_point

      return redirect_to activate_points_path
    end

    barman_invite = BarmanInvite.find_by(code: params[:code])

    if barman_invite.present?
      point = barman_invite.point

      if current_user.has_role? :admin, point
        flash[:error] = t :you_already_are_owner

        return redirect_to activate_points_path
      end

      current_user.add_role :barman, point

      flash[:success] = t(:sales_point_successfully_activated, title: point.title)

      barman_invite.delete

    else
      flash[:error] = t :sales_point_not_found_by_code

      return redirect_to activate_points_path
    end

    redirect_to points_path(set: :true)
  end

  private

  def find_point
    @point = Point.find_by(id: params[:id] || params[:point_id])

    point_protect
  end

  def has_day_sale?
    if @point.day_sales.find_by(status: :opened, user: current_user).blank?
      redirect_to root_path
    end
  end
end