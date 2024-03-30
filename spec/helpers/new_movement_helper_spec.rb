require 'rails_helper'

RSpec.describe NewMovementHelper, type: :helper do
  describe '#holiday_select_tag' do
    it 'returns the correct HTML' do
      expect(helper.holiday_select_tag).to include('Policy')
      expect(helper.holiday_select_tag).to include('select_tag(:holiday_exceptions')
    end
  end

  describe '#day_select_tag' do
    it 'returns the correct HTML' do
      expect(helper.day_select_tag).to include('Day(s) exception')
      expect(helper.day_select_tag).to include('select_tag(:day_exceptions')
    end
  end

  describe '#month_select_tag' do
    it 'returns the correct HTML' do
      expect(helper.month_select_tag).to include('Month(s) exception')
      expect(helper.month_select_tag).to include('select_tag(:month_exceptions')
    end
  end
end
