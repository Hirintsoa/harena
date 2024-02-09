class TransactionChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    Turbo::StreamsChannel.broadcast_replace_to('notification_panel',
                                                target: 'notification_panel',
                                                partial: 'components/ui/notification_dropdown',
                                                locals: {
                                                  notifications: data.fetch('notifications').map {|notification| Noticed::Notification.find notification['id']}
                                                })
  end

  def mark_as_seen(data)
    Noticed::Notification.find(data.fetch 'id').mark_as_seen
  end
end
