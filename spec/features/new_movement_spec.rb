require "rails_helper"

RSpec.feature "Movement creation", type: :feature do
  let(:user) { create(:account) }

  before do
    sign_in user
  end

  scenario "User creates a new movement" do
    let(:activity) { create(:activity) }

    visit activity_income_new_path(activity)

    click_button "Create income"

    expect(page).to have_text("Movement was successfully created.")
  end
end
