class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale, :get_or_set_current_point

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
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
        @current_point = common_tuning.update(current_point: Point.with_role(:admin, current_user).first)
      end
    end
  end

end
