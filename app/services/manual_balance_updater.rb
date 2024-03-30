class ManualBalanceUpdater
  attr_reader :automation, :configuration, :operation

  def initialize(automation_id:)
    @automation = Automation.find(automation_id)
    @configuration = automation.configuration
    @operation = configuration.category.classify.constantize
  end

  def call
    TransactionValidationNotifier.with(record:, message:, webhook_url:).deliver configuration.activity.accounts
  end

  def validate
    TransactionOperator.new(automation_id: automation.id).call
  end

  def decline
    # TO DO
  end

  def postpone
    # TO DO
  end

  private

  def message
    "Requesting validation: New #{configuration.name} (#{operation.to_s.downcase}) related to the #{configuration.activity.name} activity."
  end

  def webhook_url
    
  end

  def decline_url
    
  end
end
