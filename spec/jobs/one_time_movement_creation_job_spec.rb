require 'rails_helper'

RSpec.describe OneTimeMovementCreationJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_now(attributes: attributes.merge(activity_id: activity.id), recipient: recipient, message: message) }

  let(:activity) { create(:activity, start_date: Date.current.last_week) }
  let(:attributes) { attributes_for(:movement, type: 'Income') }
  let(:recipient) { create_list(:account, 3).map(&:id) }
  let(:message) { 'Test message' }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'is in high queue' do
    expect(OneTimeMovementCreationJob.new.queue_name).to eq('high')
  end

  it 'executes perform' do
    perform_enqueued_jobs { job }
    expect(Movement.last.attributes.symbolize_keys).to include(attributes)
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
