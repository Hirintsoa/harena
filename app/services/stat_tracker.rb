# frozen_string_literal: true

class StatTracker
  attr_reader :user, :date_range

  def initialize(user, date_range = (20.days.ago..Date.today.end_of_day))
    @user = user
    @date_range = date_range
  end

  def call
    # debugger
    @user.activities.map { |activity| serialize(activity) }.flatten.compact
  end

  private

  def serialize(activity)
    target_dates(activity).map do |date|
      target_version = activity.paper_trail.version_at(date)
      next if target_version.nil?

      {
        group: activity.name,
        date: date.to_date,
        balance: target_version.balance
      }
    end
  end

  def target_dates(activity)
    target_dates = [available_range_start_date(activity), date_range.last]
    versions = activity.versions.where(created_at: date_range)
    in_range_dates = versions.collect { |version| version.created_at.to_fs(:db).split.first }
    target_dates.insert(1, in_range_dates).flatten.uniq
  end

  def available_range_start_date(activity)
    [date_range.first, activity.start_date].max
  end
end
