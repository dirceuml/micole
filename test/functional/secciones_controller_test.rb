require 'test_helper'

class SeccionesControllerTest < ActionController::TestCase
  setup do
    @seccion = secciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:secciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seccion" do
    assert_difference('Seccion.count') do
      post :create, seccion: @seccion.attributes
    end

    assert_redirected_to seccion_path(assigns(:seccion))
  end

  test "should show seccion" do
    get :show, id: @seccion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @seccion
    assert_response :success
  end

  test "should update seccion" do
    put :update, id: @seccion, seccion: @seccion.attributes
    assert_redirected_to seccion_path(assigns(:seccion))
  end

  test "should destroy seccion" do
    assert_difference('Seccion.count', -1) do
      delete :destroy, id: @seccion
    end

    assert_redirected_to secciones_path
  end
end
