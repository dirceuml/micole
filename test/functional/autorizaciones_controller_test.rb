require 'test_helper'

class AutorizacionesControllerTest < ActionController::TestCase
  setup do
    @autorizacion = autorizaciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:autorizaciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create autorizacion" do
    assert_difference('Autorizacion.count') do
      post :create, autorizacion: @autorizacion.attributes
    end

    assert_redirected_to autorizacion_path(assigns(:autorizacion))
  end

  test "should show autorizacion" do
    get :show, id: @autorizacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @autorizacion
    assert_response :success
  end

  test "should update autorizacion" do
    put :update, id: @autorizacion, autorizacion: @autorizacion.attributes
    assert_redirected_to autorizacion_path(assigns(:autorizacion))
  end

  test "should destroy autorizacion" do
    assert_difference('Autorizacion.count', -1) do
      delete :destroy, id: @autorizacion
    end

    assert_redirected_to autorizaciones_path
  end
end
