require 'test_helper'

class GclassesControllerTest < ActionController::TestCase
  setup do
    @gclass = gclasses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gclasses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gclass" do
    assert_difference('Gclass.count') do
      post :create, gclass: @gclass.attributes
    end

    assert_redirected_to gclass_path(assigns(:gclass))
  end

  test "should show gclass" do
    get :show, id: @gclass.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gclass.to_param
    assert_response :success
  end

  test "should update gclass" do
    put :update, id: @gclass.to_param, gclass: @gclass.attributes
    assert_redirected_to gclass_path(assigns(:gclass))
  end

  test "should destroy gclass" do
    assert_difference('Gclass.count', -1) do
      delete :destroy, id: @gclass.to_param
    end

    assert_redirected_to gclasses_path
  end
end
