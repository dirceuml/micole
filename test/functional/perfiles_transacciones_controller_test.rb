require 'test_helper'

class PerfilesTransaccionesControllerTest < ActionController::TestCase
  setup do
    @perfil_transaccione = perfiles_transacciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:perfiles_transacciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create perfil_transaccione" do
    assert_difference('PerfilTransaccion.count') do
      post :create, perfil_transaccione: @perfil_transaccione.attributes
    end

    assert_redirected_to perfil_transaccione_path(assigns(:perfil_transaccione))
  end

  test "should show perfil_transaccione" do
    get :show, id: @perfil_transaccione
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @perfil_transaccione
    assert_response :success
  end

  test "should update perfil_transaccione" do
    put :update, id: @perfil_transaccione, perfil_transaccione: @perfil_transaccione.attributes
    assert_redirected_to perfil_transaccione_path(assigns(:perfil_transaccione))
  end

  test "should destroy perfil_transaccione" do
    assert_difference('PerfilTransaccion.count', -1) do
      delete :destroy, id: @perfil_transaccione
    end

    assert_redirected_to perfiles_transacciones_path
  end
end
