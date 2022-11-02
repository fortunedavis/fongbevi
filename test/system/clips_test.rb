require "application_system_test_case"

class ClipsTest < ApplicationSystemTestCase
  setup do
    @clip = clips(:one)
  end

  test "visiting the index" do
    visit clips_url
    assert_selector "h1", text: "Clips"
  end

  test "should create clip" do
    visit clips_url
    click_on "New clip"

    check "Is valid" if @clip.is_valid
    check "Need votes" if @clip.need_votes
    click_on "Create Clip"

    assert_text "Clip was successfully created"
    click_on "Back"
  end

  test "should update Clip" do
    visit clip_url(@clip)
    click_on "Edit this clip", match: :first

    check "Is valid" if @clip.is_valid
    check "Need votes" if @clip.need_votes
    click_on "Update Clip"

    assert_text "Clip was successfully updated"
    click_on "Back"
  end

  test "should destroy Clip" do
    visit clip_url(@clip)
    click_on "Destroy this clip", match: :first

    assert_text "Clip was successfully destroyed"
  end
end
