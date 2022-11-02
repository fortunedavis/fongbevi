require "application_system_test_case"

class SentencesTest < ApplicationSystemTestCase
  setup do
    @sentence = sentences(:one)
  end

  test "visiting the index" do
    visit sentences_url
    assert_selector "h1", text: "Sentences"
  end

  test "should create sentence" do
    visit sentences_url
    click_on "New sentence"

    fill_in "Clips count", with: @sentence.clips_count
    fill_in "Content", with: @sentence.content
    check "Has valid clips" if @sentence.has_valid_clips
    check "Is used" if @sentence.is_used
    click_on "Create Sentence"

    assert_text "Sentence was successfully created"
    click_on "Back"
  end

  test "should update Sentence" do
    visit sentence_url(@sentence)
    click_on "Edit this sentence", match: :first

    fill_in "Clips count", with: @sentence.clips_count
    fill_in "Content", with: @sentence.content
    check "Has valid clips" if @sentence.has_valid_clips
    check "Is used" if @sentence.is_used
    click_on "Update Sentence"

    assert_text "Sentence was successfully updated"
    click_on "Back"
  end

  test "should destroy Sentence" do
    visit sentence_url(@sentence)
    click_on "Destroy this sentence", match: :first

    assert_text "Sentence was successfully destroyed"
  end
end
