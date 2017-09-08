require 'test_helper'

class GooglesheetsControllerTest < ActionController::TestCase
  setup do
    @googlesheet = googlesheets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:googlesheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create googlesheet" do
    assert_difference('Googlesheet.count') do
      post :create, googlesheet: {  }
    end

    assert_redirected_to googlesheet_path(assigns(:googlesheet))
  end

  test "should show googlesheet" do
    get :show, id: @googlesheet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @googlesheet
    assert_response :success
  end

  test "should update googlesheet" do
    patch :update, id: @googlesheet, googlesheet: {  }
    assert_redirected_to googlesheet_path(assigns(:googlesheet))
  end

  test "should destroy googlesheet" do
    assert_difference('Googlesheet.count', -1) do
      delete :destroy, id: @googlesheet
    end

    assert_redirected_to googlesheets_path
  end
end
