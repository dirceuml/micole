require 'test_helper'

class GradosControllerTest < ActionController::TestCase
  setup do
    @grado = grados(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grado" do
    assert_difference('Grado.count') do
      post :create, grado: @grado.attributes
    end

    assert_redirected_to grado_path(assigns(:grado))
  end

  test "should show grado" do
    get :show, id: @grado
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grado
    assert_response :success
  end

  test "should update grado" do
    put :update, id: @grado, grado: @grado.attributes
    assert_redirected_to grado_path(assigns(:grado))
  end

  test "should destroy grado" do
    assert_difference('Grado.count', -1) do
      delete :destroy, id: @grado
    end

    assert_redirected_to grados_path
  end
end
