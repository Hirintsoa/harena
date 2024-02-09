class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit
  before_action :set_notifications

  def user_for_paper_trail
    account_signed_in? ? current_account.id : 'Public user'  # or whatever
  end

  def info_for_paper_trail
    { ip: request&.remote_ip, user_agent: request&.user_agent } if account_signed_in?
  end

  private

  def set_notifications
    @notifications = current_account.notifications.newest_first if account_signed_in?
  end
end
