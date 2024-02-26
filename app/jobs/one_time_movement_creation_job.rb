class OneTimeMovementCreationJob < ApplicationJob
  queue_as :high

  def perform(attributes:, recipient:, message:)
    new_movement = Movement.create(**attributes)
    NewTransactionNotifier.with(record: new_movement, message:).deliver recipient unless recipient.empty?
  end
end
