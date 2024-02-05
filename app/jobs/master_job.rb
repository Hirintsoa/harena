class MasterJob < ApplicationJob
  queue_as :urgent

  def perform(*args)
    Automation.jobs_to_run.map do |job|
      job.operator_class.constantize.perform_later(automation_id: job.id)
    end
  end
end
