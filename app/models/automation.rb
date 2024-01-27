class Automation < ApplicationRecord
  belongs_to :configuration
  belongs_to :activity
end
