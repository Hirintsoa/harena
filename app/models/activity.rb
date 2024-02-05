class Activity < ApplicationRecord
  ## Summary
  # The `Activity` class represents an activity and has various functionalities related to it, such as validations, associations, and tracking changes.
  # It also has methods to add and subtract amounts from the balance field.

  ## Fields
  # - `name`: A required field that represents the name of the activity.
  # - `start_date`: A required field that represents the start date of the activity.
  # - `balance`: A field that represents the balance of the activity, which can be updated using the `add` and `subtract` methods.

  ## Validations
  validates :name, :start_date, presence: true

  ## Associations
  has_many :activity_participants
  has_many :accounts, through: :activity_participants

  ## Tracking Changes
  has_paper_trail only: [:balance], on: [:create, :update]

  ## Public Methods

  # Adds the specified `amount` to the `balance` field of the activity.
  #
  # @param amount [Numeric] The amount to be added to the balance.
  def add(amount)
    self.balance += amount
  end

  # Subtracts the specified `amount` from the `balance` field of the activity.
  #
  # @param amount [Numeric] The amount to be subtracted from the balance.
  def substract(amount)
    self.balance -= amount
  end
end
