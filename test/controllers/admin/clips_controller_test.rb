require "test_helper"

class Admin::ClipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_clip = admin_clips(:one)
  end

  test "should get index" do
    get admin_clips_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_clip_url
    assert_response :success
  end

  test "should create admin_clip" do
    assert_difference("Admin::Clip.count") do
      post admin_clips_url, params: { admin_clip: {  } }
    end

    assert_redirected_to admin_clip_url(Admin::Clip.last)
  end

  test "should show admin_clip" do
    get admin_clip_url(@admin_clip)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_clip_url(@admin_clip)
    assert_response :success
  end

  test "should update admin_clip" do
    patch admin_clip_url(@admin_clip), params: { admin_clip: {  } }
    assert_redirected_to admin_clip_url(@admin_clip)
  end

  test "should destroy admin_clip" do
    assert_difference("Admin::Clip.count", -1) do
      delete admin_clip_url(@admin_clip)
    end

    assert_redirected_to admin_clips_url
  end
end
