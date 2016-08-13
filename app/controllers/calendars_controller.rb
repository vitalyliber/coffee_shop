class CalendarsController < ApplicationController
  before_action :has_access?

  private

  def has_access?
    unless current_user.has_any_role? :barman, :admin
      redirect_to root_path
    end
  end
end
