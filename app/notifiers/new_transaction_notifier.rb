# To deliver this notification:
#
# NewTransaction.with(record: @post, message: "New post").deliver(User.all)

class NewTransactionNotifier < ApplicationNotifier
  deliver_by :action_cable do |config|
    config.channel = 'TransactionChannel'
    config.message = ->{ params.merge(user_id: recipient.id, notifications: recipient.notifications) }
  end
  
  # deliver_by :email do |config|
  #   config.mailer = "AccountMailer"
  #   config.method = "new_transaction"
  #   config.if = ->(recipient) { recipient.mail_notifications? }
  #   config.wait = 1.hour
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  required_param :message

  notification_methods do
    def message
      params[:message]
    end
  end
end
