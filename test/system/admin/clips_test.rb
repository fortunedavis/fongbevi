require "application_system_test_case"

class Admin::ClipsTest < ApplicationSystemTestCase
  setup do
    @admin_clip = admin_clips(:one)
  end

  test "visiting the index" do
    visit admin_clips_url
    assert_selector "h1", text: "Clips"
  end

  test "should create clip" do
    visit admin_clips_url
    click_on "New clip"

    click_on "Create Clip"

    assert_text "Clip was successfully created"
    click_on "Back"
  end

  test "should update Clip" do
    visit admin_clip_url(@admin_clip)
    click_on "Edit this clip", match: :first

    click_on "Update Clip"

    assert_text "Clip was successfully updated"
    click_on "Back"
  end

  test "should destroy Clip" do
    visit admin_clip_url(@admin_clip)
    click_on "Destroy this clip", match: :first

    assert_text "Clip was successfully destroyed"
  end
end
