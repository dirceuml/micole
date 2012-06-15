require 'test_helper'

class PersonaAutorizadaRecojosControllerTest < ActionController::TestCase
  setup do
    @persona_autorizada_recojo = persona_autorizada_recojos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:persona_autorizada_recojos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create persona_autorizada_recojo" do
    assert_difference('PersonaAutorizadaRecojo.count') do
      post :create, persona_autorizada_recojo: @persona_autorizada_recojo.attributes
    end

    assert_redirected_to persona_autorizada_recojo_path(assigns(:persona_autorizada_recojo))
  end

  test "should show persona_autorizada_recojo" do
    get :show, id: @persona_autorizada_recojo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @persona_autorizada_recojo
    assert_response :success
  end

  test "should update persona_autorizada_recojo" do
    put :update, id: @persona_autorizada_recojo, persona_autorizada_recojo: @persona_autorizada_recojo.attributes
    assert_redirected_to persona_autorizada_recojo_path(assigns(:persona_autorizada_recojo))
  end

  test "should destroy persona_autorizada_recojo" do
    assert_difference('PersonaAutorizadaRecojo.count', -1) do
      delete :destroy, id: @persona_autorizada_recojo
    end

    assert_redirected_to persona_autorizada_recojos_path
  end
end
