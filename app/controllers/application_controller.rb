class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale, :get_or_set_current_point, :add_barman_to_point

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    extracted_locale = extract_locale_from_accept_language_header

    extracted_locale = 'en' unless ['en', 'ru'].include?(extracted_locale)

    I18n.locale = extracted_locale
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def get_or_set_current_point
    if current_user.present?
      common_tuning = CommonTuning.find_by(user: current_user)

      @current_point = common_tuning.try(:current_point)

      if @current_point.blank?
        @current_point = common_tuning.update(
            current_point:
                Point.with_role(:admin, current_user).first ||
                Point.with_role(:barman, current_user).first
        )
      end

    end
  end

  def point_protect
    @point = @point || Point.find_by(id: params[:id] || params[:point_id])

    unless (current_user.has_role? :admin, @point) or current_user.has_role? :barman, @point
      flash[:error] = t :access_denied

      point_set_to_default

      return redirect_to points_path(set: 'point')
    end
  end

  def point_admin_protect
    @point = @point || Point.find_by(id: params[:point_id])

    unless current_user.has_role? :admin, @point
      flash[:error] = t :access_denied

      point_set_to_default

      return redirect_to points_path(set: 'point')
    end
  end

  def point_set_to_default
    common_tuning = CommonTuning.find_by(user: current_user)

    @current_point = common_tuning.update(current_point: Point.with_role(:admin, current_user).first)
  end

  def add_barman_to_point
    if cookies[:barman_code].present? and current_user.present?
      barman_invite = BarmanInvite.find_by(code: cookies[:barman_code])

      if barman_invite.present?
        point = barman_invite.point

        unless current_user.has_role? :admin, point
          current_user.add_role :barman, point

          flash[:success] = t(:sales_point_successfully_activated, title: point.title)

          barman_invite.delete

          common_tuning = CommonTuning.find_by(user: current_user)
          common_tuning.update(current_point: point)
        end

      end

      cookies.delete :barman_code
    end
  end

end
