require 'test_helper'

class CuadernoControlesEventosControllerTest < ActionController::TestCase
  setup do
    @cuaderno_control_evento = cuaderno_controles_eventos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuaderno_controles_eventos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuaderno_control_evento" do
    assert_difference('CuadernoControlEvento.count') do
      post :create, cuaderno_control_evento: @cuaderno_control_evento.attributes
    end

    assert_redirected_to cuaderno_control_evento_path(assigns(:cuaderno_control_evento))
  end

  test "should show cuaderno_control_evento" do
    get :show, id: @cuaderno_control_evento
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cuaderno_control_evento
    assert_response :success
  end

  test "should update cuaderno_control_evento" do
    put :update, id: @cuaderno_control_evento, cuaderno_control_evento: @cuaderno_control_evento.attributes
    assert_redirected_to cuaderno_control_evento_path(assigns(:cuaderno_control_evento))
  end

  test "should destroy cuaderno_control_evento" do
    assert_difference('CuadernoControlEvento.count', -1) do
      delete :destroy, id: @cuaderno_control_evento
    end

    assert_redirected_to cuaderno_controles_eventos_path
  end
end
