require 'test_helper'

class TiposNotasControllerTest < ActionController::TestCase
  setup do
    @tipo_nota = tipos_notas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipos_notas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_nota" do
    assert_difference('TipoNota.count') do
      post :create, tipo_nota: @tipo_nota.attributes
    end

    assert_redirected_to tipo_nota_path(assigns(:tipo_nota))
  end

  test "should show tipo_nota" do
    get :show, id: @tipo_nota
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_nota
    assert_response :success
  end

  test "should update tipo_nota" do
    put :update, id: @tipo_nota, tipo_nota: @tipo_nota.attributes
    assert_redirected_to tipo_nota_path(assigns(:tipo_nota))
  end

  test "should destroy tipo_nota" do
    assert_difference('TipoNota.count', -1) do
      delete :destroy, id: @tipo_nota
    end

    assert_redirected_to tipos_notas_path
  end
end
