require 'test_helper'

class PersonasVinculadasControllerTest < ActionController::TestCase
  setup do
    @persona_vinculada = personas_vinculadas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personas_vinculadas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create persona_vinculada" do
    assert_difference('PersonaVinculada.count') do
      post :create, persona_vinculada: @persona_vinculada.attributes
    end

    assert_redirected_to persona_vinculada_path(assigns(:persona_vinculada))
  end

  test "should show persona_vinculada" do
    get :show, id: @persona_vinculada
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @persona_vinculada
    assert_response :success
  end

  test "should update persona_vinculada" do
    put :update, id: @persona_vinculada, persona_vinculada: @persona_vinculada.attributes
    assert_redirected_to persona_vinculada_path(assigns(:persona_vinculada))
  end

  test "should destroy persona_vinculada" do
    assert_difference('PersonaVinculada.count', -1) do
      delete :destroy, id: @persona_vinculada
    end

    assert_redirected_to personas_vinculadas_path
  end
end
