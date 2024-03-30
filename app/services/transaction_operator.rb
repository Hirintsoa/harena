class TransactionOperator
  attr_reader :automation, :configuration, :operation

  def initialize(automation_id:)
    @automation = Automation.find(automation_id)
    @configuration = automation.configuration
    @operation = configuration.category.classify.constantize
  end

  def call
    record = ActiveRecord::Base.transaction do
      update_balance
      ExecutionScheduler.new(automation: automation).set_next_execution
      create_record
    end

    NewTransactionNotifier.with(record:, message:).deliver automation.activity.accounts
  rescue => err
    Rails.logger.error err.message 
  end

  private

  def create_record
    operation.create(
      name:  'Automated transaction',
      description:  "Automation #{@automation.id} / datetime: #{Time.now}",
      amount: configuration.amount,
      activity_id: automation.activity.id
    )
  end

  def update_balance
    automation.activity.public_send(define_action.to_sym, configuration.amount)
  end

  def define_action
    configuration.category.constantize == Income ? 'add' : 'substract'
  end

  def message
    "#{automation.activity.name} activity: New #{operation.to_s.downcase} related to #{configuration.name}."
  end
end
