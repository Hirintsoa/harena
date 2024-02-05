require "rails_helper"

RSpec.describe ExecutionScheduler do
  describe "when there is no exception" do
    let(:config) {
        create(:configuration,
                range_amount: 3,
                base: 'month',
                name: 'Retirement Pension',
                amount: Faker::Commerce.price(range: 400..1800.0))
    }

    let(:activity) { create(:activity, name: 'Internal Activity', start_date: Date.current.last_month) }

    let(:current_ref_date) { "2024-02-02".to_date }

    let(:automation) {
                        create(:automation,
                              next_execution: current_ref_date,
                              configuration: config,
                              activity: activity)
                      }

    it "updates the next_execution attribute", :focus => true do
      scheduler = ExecutionScheduler.new(automation: automation)
      scheduler.set_next_execution
      expect(automation.next_execution).to eq(current_ref_date.in(3.months))
    end
  end

  describe 'when configuration represents a "basic" daily weekday routine' do
    let(:config) {
      create(:configuration,
              category: 'Expense',
              name: 'Daily work',
              amount: Faker::Commerce.price(range: 20..100.0))
    }

    let(:activity) { create(:activity, start_date: Date.current.last_week) }

    let(:current_ref_date) { "2024-02-02".to_date }

    let(:automation) {
                        create(:automation,
                              next_execution: current_ref_date,
                              configuration: config,
                              activity: activity)
                      }

    before do
      create(:config_exception, value: 'Weekend', configuration: config)
    end

    it "updates the next_execution attribute" do
      scheduler = ExecutionScheduler.new(automation: automation)
      scheduler.set_next_execution
      expect(automation.next_execution).to eq(current_ref_date.next_week)
    end

    describe "#next_execution" do
      let(:current_ref_date) { "2024-01-31".to_date }

      before do
        create(:config_exception, value: 'February', configuration: config)
        create(:config_exception, value: 'Friday', configuration: config)
      end

      it "evaluates correctly multiple exceptions" do
        scheduler = ExecutionScheduler.new(automation: automation)
        res = scheduler.send(:next_execution)
        expect(res).to eq(current_ref_date.next.next_month.next_occurring(:monday))
      end
    end
  end
end