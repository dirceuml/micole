require 'test_helper'

class NotasControllerTest < ActionController::TestCase
  setup do
    @nota = notas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nota" do
    assert_difference('Nota.count') do
      post :create, nota: @nota.attributes
    end

    assert_redirected_to nota_path(assigns(:nota))
  end

  test "should show nota" do
    get :show, id: @nota
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nota
    assert_response :success
  end

  test "should update nota" do
    put :update, id: @nota, nota: @nota.attributes
    assert_redirected_to nota_path(assigns(:nota))
  end

  test "should destroy nota" do
    assert_difference('Nota.count', -1) do
      delete :destroy, id: @nota
    end

    assert_redirected_to notas_path
  end
end
