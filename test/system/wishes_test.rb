require "application_system_test_case"

class WishesTest < ApplicationSystemTestCase
  setup do
    @wish = wishes(:one)
  end

  test "visiting the index" do
    visit wishes_url
    assert_selector "h1", text: "Wishes"
  end

  test "should create wish" do
    visit wishes_url
    click_on "New wish"

    fill_in "Activity", with: @wish.activity_id
    fill_in "Description", with: @wish.description
    fill_in "Estimation", with: @wish.estimation
    fill_in "Name", with: @wish.name
    fill_in "Priority", with: @wish.priority
    click_on "Create Wish"

    assert_text "Wish was successfully created"
    click_on "Back"
  end

  test "should update Wish" do
    visit wish_url(@wish)
    click_on "Edit this wish", match: :first

    fill_in "Activity", with: @wish.activity_id
    fill_in "Description", with: @wish.description
    fill_in "Estimation", with: @wish.estimation
    fill_in "Name", with: @wish.name
    fill_in "Priority", with: @wish.priority
    click_on "Update Wish"

    assert_text "Wish was successfully updated"
    click_on "Back"
  end

  test "should destroy Wish" do
    visit wish_url(@wish)
    click_on "Destroy this wish", match: :first

    assert_text "Wish was successfully destroyed"
  end
end
