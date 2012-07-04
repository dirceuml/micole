require 'test_helper'

class CuadernoControlesRevisionesControllerTest < ActionController::TestCase
  setup do
    @cuaderno_control_revisione = cuaderno_controles_revisiones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuaderno_controles_revisiones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuaderno_control_revisione" do
    assert_difference('CuadernoControlRevision.count') do
      post :create, cuaderno_control_revisione: @cuaderno_control_revisione.attributes
    end

    assert_redirected_to cuaderno_control_revisione_path(assigns(:cuaderno_control_revisione))
  end

  test "should show cuaderno_control_revisione" do
    get :show, id: @cuaderno_control_revisione
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cuaderno_control_revisione
    assert_response :success
  end

  test "should update cuaderno_control_revisione" do
    put :update, id: @cuaderno_control_revisione, cuaderno_control_revisione: @cuaderno_control_revisione.attributes
    assert_redirected_to cuaderno_control_revisione_path(assigns(:cuaderno_control_revisione))
  end

  test "should destroy cuaderno_control_revisione" do
    assert_difference('CuadernoControlRevision.count', -1) do
      delete :destroy, id: @cuaderno_control_revisione
    end

    assert_redirected_to cuaderno_controles_revisiones_path
  end
end
