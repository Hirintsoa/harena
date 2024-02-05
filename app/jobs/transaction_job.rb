class TransactionJob < ApplicationJob
  queue_as :default

  def perform(automation_id:)
    if Automation.find(automation_id).configuration.automatic
      TransactionOperator.new(automation_id: automation_id).call
    else
      # TO DO
    end
  end
end
