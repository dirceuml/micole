require 'test_helper'

class ActividadesSeccionesControllerTest < ActionController::TestCase
  setup do
    @actividad_seccione = actividades_secciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:actividades_secciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create actividad_seccione" do
    assert_difference('ActividadSeccion.count') do
      post :create, actividad_seccione: @actividad_seccione.attributes
    end

    assert_redirected_to actividad_seccione_path(assigns(:actividad_seccione))
  end

  test "should show actividad_seccione" do
    get :show, id: @actividad_seccione
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @actividad_seccione
    assert_response :success
  end

  test "should update actividad_seccione" do
    put :update, id: @actividad_seccione, actividad_seccione: @actividad_seccione.attributes
    assert_redirected_to actividad_seccione_path(assigns(:actividad_seccione))
  end

  test "should destroy actividad_seccione" do
    assert_difference('ActividadSeccion.count', -1) do
      delete :destroy, id: @actividad_seccione
    end

    assert_redirected_to actividades_secciones_path
  end
end
