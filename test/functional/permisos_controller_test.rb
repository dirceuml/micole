require 'test_helper'

class PermisosControllerTest < ActionController::TestCase
  setup do
    @permiso = permisos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:permisos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create permiso" do
    assert_difference('Permiso.count') do
      post :create, permiso: @permiso.attributes
    end

    assert_redirected_to permiso_path(assigns(:permiso))
  end

  test "should show permiso" do
    get :show, id: @permiso
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @permiso
    assert_response :success
  end

  test "should update permiso" do
    put :update, id: @permiso, permiso: @permiso.attributes
    assert_redirected_to permiso_path(assigns(:permiso))
  end

  test "should destroy permiso" do
    assert_difference('Permiso.count', -1) do
      delete :destroy, id: @permiso
    end

    assert_redirected_to permisos_path
  end
end
