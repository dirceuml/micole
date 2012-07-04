require 'test_helper'

class PerfilesControllerTest < ActionController::TestCase
  setup do
    @perfil = perfiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:perfiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create perfil" do
    assert_difference('Perfil.count') do
      post :create, perfil: @perfil.attributes
    end

    assert_redirected_to perfil_path(assigns(:perfil))
  end

  test "should show perfil" do
    get :show, id: @perfil
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @perfil
    assert_response :success
  end

  test "should update perfil" do
    put :update, id: @perfil, perfil: @perfil.attributes
    assert_redirected_to perfil_path(assigns(:perfil))
  end

  test "should destroy perfil" do
    assert_difference('Perfil.count', -1) do
      delete :destroy, id: @perfil
    end

    assert_redirected_to perfiles_path
  end
end
