FactoryBot.define do
  factory :automation do
    operator_class { "TransactionJob" }
    configuration
    activity
    next_execution { "2024-02-04" }
  end
end
