require 'rails_helper'

RSpec.describe "New movement", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:account) { create(:account) }
  let(:activity) { create(:activity) }

  before do
    sign_in account
  end

  describe 'POST #base_step' do
    context 'when period is immediate' do
      it 'creates a one time movement immediately' do
        post activity_new_movement_base_step_path(activity_id: activity.id, period: 'immediate')

        expect(response).to redirect_to(activity_path(activity))
      end
    end

    context 'when period is delayed' do
      it 'schedules a one time movement' do
        post activity_new_movement_base_step_path(
                                          activity_id: activity.id,
                                          period: 'delayed',
                                          execution_time: (Time.now + 1.day).to_s
                                        )
        expect(response).to redirect_to(activity_path(activity))
      end
    end
  end

  describe 'POST #configuration_step' do
    it 'creates a configuration' do
      post new_movement_configuration_step_path(activity_id: activity.id)
      expect(response).to render_template(activity)
      expect(flash[:notice]).to eq('flash.created')
    end
  end

end
