require 'test_helper'

class AniosEscolaresControllerTest < ActionController::TestCase
  setup do
    @anio_escolar = anios_escolares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:anios_escolares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create anio_escolar" do
    assert_difference('AnioEscolar.count') do
      post :create, anio_escolar: @anio_escolar.attributes
    end

    assert_redirected_to anio_escolar_path(assigns(:anio_escolar))
  end

  test "should show anio_escolar" do
    get :show, id: @anio_escolar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @anio_escolar
    assert_response :success
  end

  test "should update anio_escolar" do
    put :update, id: @anio_escolar, anio_escolar: @anio_escolar.attributes
    assert_redirected_to anio_escolar_path(assigns(:anio_escolar))
  end

  test "should destroy anio_escolar" do
    assert_difference('AnioEscolar.count', -1) do
      delete :destroy, id: @anio_escolar
    end

    assert_redirected_to anios_escolares_path
  end
end
