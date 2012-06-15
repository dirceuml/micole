require 'test_helper'

class CuadernoControlsControllerTest < ActionController::TestCase
  setup do
    @cuaderno_control = cuaderno_controls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuaderno_controls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuaderno_control" do
    assert_difference('CuadernoControl.count') do
      post :create, cuaderno_control: @cuaderno_control.attributes
    end

    assert_redirected_to cuaderno_control_path(assigns(:cuaderno_control))
  end

  test "should show cuaderno_control" do
    get :show, id: @cuaderno_control
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cuaderno_control
    assert_response :success
  end

  test "should update cuaderno_control" do
    put :update, id: @cuaderno_control, cuaderno_control: @cuaderno_control.attributes
    assert_redirected_to cuaderno_control_path(assigns(:cuaderno_control))
  end

  test "should destroy cuaderno_control" do
    assert_difference('CuadernoControl.count', -1) do
      delete :destroy, id: @cuaderno_control
    end

    assert_redirected_to cuaderno_controls_path
  end
end
