require 'test_helper'

class ControlesAsistenciasControllerTest < ActionController::TestCase
  setup do
    @control_asistencia = controles_asistencias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:controles_asistencias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create control_asistencia" do
    assert_difference('ControlAsistencia.count') do
      post :create, control_asistencia: { anio_alumno_id: @control_asistencia.anio_alumno_id, tipo_asistencia: @control_asistencia.tipo_asistencia }
    end

    assert_redirected_to control_asistencia_path(assigns(:control_asistencia))
  end

  test "should show control_asistencia" do
    get :show, id: @control_asistencia
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @control_asistencia
    assert_response :success
  end

  test "should update control_asistencia" do
    put :update, id: @control_asistencia, control_asistencia: { anio_alumno_id: @control_asistencia.anio_alumno_id, tipo_asistencia: @control_asistencia.tipo_asistencia }
    assert_redirected_to control_asistencia_path(assigns(:control_asistencia))
  end

  test "should destroy control_asistencia" do
    assert_difference('ControlAsistencia.count', -1) do
      delete :destroy, id: @control_asistencia
    end

    assert_redirected_to controles_asistencias_path
  end
end
