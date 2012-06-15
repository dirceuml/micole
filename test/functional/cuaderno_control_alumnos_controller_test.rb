require 'test_helper'

class CuadernoControlAlumnosControllerTest < ActionController::TestCase
  setup do
    @cuaderno_control_alumno = cuaderno_control_alumnos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuaderno_control_alumnos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuaderno_control_alumno" do
    assert_difference('CuadernoControlAlumno.count') do
      post :create, cuaderno_control_alumno: @cuaderno_control_alumno.attributes
    end

    assert_redirected_to cuaderno_control_alumno_path(assigns(:cuaderno_control_alumno))
  end

  test "should show cuaderno_control_alumno" do
    get :show, id: @cuaderno_control_alumno
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cuaderno_control_alumno
    assert_response :success
  end

  test "should update cuaderno_control_alumno" do
    put :update, id: @cuaderno_control_alumno, cuaderno_control_alumno: @cuaderno_control_alumno.attributes
    assert_redirected_to cuaderno_control_alumno_path(assigns(:cuaderno_control_alumno))
  end

  test "should destroy cuaderno_control_alumno" do
    assert_difference('CuadernoControlAlumno.count', -1) do
      delete :destroy, id: @cuaderno_control_alumno
    end

    assert_redirected_to cuaderno_control_alumnos_path
  end
end
