require 'test_helper'

class CuadernoControlSeccionsControllerTest < ActionController::TestCase
  setup do
    @cuaderno_control_seccion = cuaderno_control_seccions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuaderno_control_seccions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuaderno_control_seccion" do
    assert_difference('CuadernoControlSeccion.count') do
      post :create, cuaderno_control_seccion: @cuaderno_control_seccion.attributes
    end

    assert_redirected_to cuaderno_control_seccion_path(assigns(:cuaderno_control_seccion))
  end

  test "should show cuaderno_control_seccion" do
    get :show, id: @cuaderno_control_seccion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cuaderno_control_seccion
    assert_response :success
  end

  test "should update cuaderno_control_seccion" do
    put :update, id: @cuaderno_control_seccion, cuaderno_control_seccion: @cuaderno_control_seccion.attributes
    assert_redirected_to cuaderno_control_seccion_path(assigns(:cuaderno_control_seccion))
  end

  test "should destroy cuaderno_control_seccion" do
    assert_difference('CuadernoControlSeccion.count', -1) do
      delete :destroy, id: @cuaderno_control_seccion
    end

    assert_redirected_to cuaderno_control_seccions_path
  end
end
