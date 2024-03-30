class DashboardController < ApplicationController
  before_action :authenticate_account!
  def index
    @stats = StatTracker.new(current_account).call
    @notifications = current_account.notifications.newest_first
    @activities = current_account.activities
    # Turbo::StreamsChannel.broadcast_replace_to(
    #   "current_account",
    #   target: 'notification_panel',
    #   partial: 'components/ui/notification_label',
    #   locals: { notifications_count: Faker::Number.between(from: 5,to: 5000) }
    # )
  end
end
