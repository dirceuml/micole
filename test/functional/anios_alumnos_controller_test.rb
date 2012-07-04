require 'test_helper'

class AniosAlumnosControllerTest < ActionController::TestCase
  setup do
    @anio_alumno = anios_alumnos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:anios_alumnos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create anio_alumno" do
    assert_difference('AnioAlumno.count') do
      post :create, anio_alumno: @anio_alumno.attributes
    end

    assert_redirected_to anio_alumno_path(assigns(:anio_alumno))
  end

  test "should show anio_alumno" do
    get :show, id: @anio_alumno
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @anio_alumno
    assert_response :success
  end

  test "should update anio_alumno" do
    put :update, id: @anio_alumno, anio_alumno: @anio_alumno.attributes
    assert_redirected_to anio_alumno_path(assigns(:anio_alumno))
  end

  test "should destroy anio_alumno" do
    assert_difference('AnioAlumno.count', -1) do
      delete :destroy, id: @anio_alumno
    end

    assert_redirected_to anios_alumnos_path
  end
end
