class ActivityParticipant < ApplicationRecord
  belongs_to :activity
  belongs_to :account
end
