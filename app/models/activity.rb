class Activity < ApplicationRecord
  validates :name, presence: true
  validates :start_date, presence: true
  has_many :activity_participants
  has_many :accounts, through: :activity_participants
  has_paper_trail only: [:balance], on: [:create, :update]
end
