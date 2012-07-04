require 'test_helper'

class AlumnosPersonasVinculadasControllerTest < ActionController::TestCase
  setup do
    @alumno_persona_vinculada = alumnos_personas_vinculadas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alumnos_personas_vinculadas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alumno_persona_vinculada" do
    assert_difference('AlumnoPersonaVinculada.count') do
      post :create, alumno_persona_vinculada: @alumno_persona_vinculada.attributes
    end

    assert_redirected_to alumno_persona_vinculada_path(assigns(:alumno_persona_vinculada))
  end

  test "should show alumno_persona_vinculada" do
    get :show, id: @alumno_persona_vinculada
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alumno_persona_vinculada
    assert_response :success
  end

  test "should update alumno_persona_vinculada" do
    put :update, id: @alumno_persona_vinculada, alumno_persona_vinculada: @alumno_persona_vinculada.attributes
    assert_redirected_to alumno_persona_vinculada_path(assigns(:alumno_persona_vinculada))
  end

  test "should destroy alumno_persona_vinculada" do
    assert_difference('AlumnoPersonaVinculada.count', -1) do
      delete :destroy, id: @alumno_persona_vinculada
    end

    assert_redirected_to alumnos_personas_vinculadas_path
  end
end
