require 'test_helper'

class UsuariosSeccionesControllerTest < ActionController::TestCase
  setup do
    @usuario_seccion = usuarios_secciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usuarios_secciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usuario_seccion" do
    assert_difference('UsuarioSeccion.count') do
      post :create, usuario_seccion: { asigna_actividad: @usuario_seccion.asigna_actividad, revisa_asistencia,: @usuario_seccion.revisa_asistencia,, revisa_autorizacion: @usuario_seccion.revisa_autorizacion, seccion_id: @usuario_seccion.seccion_id, usuario: @usuario_seccion.usuario, usuario_id: @usuario_seccion.usuario_id, verifica_cuaderno_control: @usuario_seccion.verifica_cuaderno_control }
    end

    assert_redirected_to usuario_seccion_path(assigns(:usuario_seccion))
  end

  test "should show usuario_seccion" do
    get :show, id: @usuario_seccion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usuario_seccion
    assert_response :success
  end

  test "should update usuario_seccion" do
    put :update, id: @usuario_seccion, usuario_seccion: { asigna_actividad: @usuario_seccion.asigna_actividad, revisa_asistencia,: @usuario_seccion.revisa_asistencia,, revisa_autorizacion: @usuario_seccion.revisa_autorizacion, seccion_id: @usuario_seccion.seccion_id, usuario: @usuario_seccion.usuario, usuario_id: @usuario_seccion.usuario_id, verifica_cuaderno_control: @usuario_seccion.verifica_cuaderno_control }
    assert_redirected_to usuario_seccion_path(assigns(:usuario_seccion))
  end

  test "should destroy usuario_seccion" do
    assert_difference('UsuarioSeccion.count', -1) do
      delete :destroy, id: @usuario_seccion
    end

    assert_redirected_to usuarios_secciones_path
  end
end
