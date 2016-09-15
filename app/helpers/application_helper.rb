module ApplicationHelper

  def opened_day_sale?
    if @point.present?
      @point.day_sales.find_by(status: :opened, user: current_user).present?
    end
  end

end
