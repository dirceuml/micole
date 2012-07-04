require 'test_helper'

class ListasValoresControllerTest < ActionController::TestCase
  setup do
    @lista_valor = listas_valores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:listas_valores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lista_valor" do
    assert_difference('ListaValor.count') do
      post :create, lista_valor: @lista_valor.attributes
    end

    assert_redirected_to lista_valor_path(assigns(:lista_valor))
  end

  test "should show lista_valor" do
    get :show, id: @lista_valor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lista_valor
    assert_response :success
  end

  test "should update lista_valor" do
    put :update, id: @lista_valor, lista_valor: @lista_valor.attributes
    assert_redirected_to lista_valor_path(assigns(:lista_valor))
  end

  test "should destroy lista_valor" do
    assert_difference('ListaValor.count', -1) do
      delete :destroy, id: @lista_valor
    end

    assert_redirected_to listas_valores_path
  end
end
