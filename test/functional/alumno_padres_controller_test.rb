require 'test_helper'

class AlumnoPadresControllerTest < ActionController::TestCase
  setup do
    @alumno_padre = alumno_padres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alumno_padres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alumno_padre" do
    assert_difference('AlumnoPadre.count') do
      post :create, alumno_padre: @alumno_padre.attributes
    end

    assert_redirected_to alumno_padre_path(assigns(:alumno_padre))
  end

  test "should show alumno_padre" do
    get :show, id: @alumno_padre
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alumno_padre
    assert_response :success
  end

  test "should update alumno_padre" do
    put :update, id: @alumno_padre, alumno_padre: @alumno_padre.attributes
    assert_redirected_to alumno_padre_path(assigns(:alumno_padre))
  end

  test "should destroy alumno_padre" do
    assert_difference('AlumnoPadre.count', -1) do
      delete :destroy, id: @alumno_padre
    end

    assert_redirected_to alumno_padres_path
  end
end
