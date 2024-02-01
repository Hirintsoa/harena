class Automation < ApplicationRecord
  belongs_to :configuration
  belongs_to :activity

  scope :jobs_to_run, -> { where(next_execution: Date.today.all_day) }
end
