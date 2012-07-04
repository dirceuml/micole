require 'test_helper'

class AsistenciasControllerTest < ActionController::TestCase
  setup do
    @asistencia = asistencias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asistencias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asistencia" do
    assert_difference('Asistencia.count') do
      post :create, asistencia: @asistencia.attributes
    end

    assert_redirected_to asistencia_path(assigns(:asistencia))
  end

  test "should show asistencia" do
    get :show, id: @asistencia
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asistencia
    assert_response :success
  end

  test "should update asistencia" do
    put :update, id: @asistencia, asistencia: @asistencia.attributes
    assert_redirected_to asistencia_path(assigns(:asistencia))
  end

  test "should destroy asistencia" do
    assert_difference('Asistencia.count', -1) do
      delete :destroy, id: @asistencia
    end

    assert_redirected_to asistencias_path
  end
end
