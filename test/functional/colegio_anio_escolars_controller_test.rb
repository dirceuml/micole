require 'test_helper'

class ColegioAnioEscolarsControllerTest < ActionController::TestCase
  setup do
    @colegio_anio_escolar = colegio_anio_escolars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:colegio_anio_escolars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create colegio_anio_escolar" do
    assert_difference('ColegioAnioEscolar.count') do
      post :create, colegio_anio_escolar: @colegio_anio_escolar.attributes
    end

    assert_redirected_to colegio_anio_escolar_path(assigns(:colegio_anio_escolar))
  end

  test "should show colegio_anio_escolar" do
    get :show, id: @colegio_anio_escolar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @colegio_anio_escolar
    assert_response :success
  end

  test "should update colegio_anio_escolar" do
    put :update, id: @colegio_anio_escolar, colegio_anio_escolar: @colegio_anio_escolar.attributes
    assert_redirected_to colegio_anio_escolar_path(assigns(:colegio_anio_escolar))
  end

  test "should destroy colegio_anio_escolar" do
    assert_difference('ColegioAnioEscolar.count', -1) do
      delete :destroy, id: @colegio_anio_escolar
    end

    assert_redirected_to colegio_anio_escolars_path
  end
end
