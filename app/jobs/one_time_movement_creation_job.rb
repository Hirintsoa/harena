class OneTimeMovementCreationJob < ApplicationJob
  queue_as :high

  def perform(record:, recipient:, message:)
    new_movement = record.save
    NewTransactionNotifier.with(record: new_movement, message:).deliver recipient unless recipient.empty?
  end
end
