require 'test_helper'

class PerfilesPermisosControllerTest < ActionController::TestCase
  setup do
    @perfil_permiso = perfiles_permisos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:perfiles_permisos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create perfil_permiso" do
    assert_difference('PerfilPermiso.count') do
      post :create, perfil_permiso: @perfil_permiso.attributes
    end

    assert_redirected_to perfil_permiso_path(assigns(:perfil_permiso))
  end

  test "should show perfil_permiso" do
    get :show, id: @perfil_permiso
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @perfil_permiso
    assert_response :success
  end

  test "should update perfil_permiso" do
    put :update, id: @perfil_permiso, perfil_permiso: @perfil_permiso.attributes
    assert_redirected_to perfil_permiso_path(assigns(:perfil_permiso))
  end

  test "should destroy perfil_permiso" do
    assert_difference('PerfilPermiso.count', -1) do
      delete :destroy, id: @perfil_permiso
    end

    assert_redirected_to perfiles_permisos_path
  end
end
