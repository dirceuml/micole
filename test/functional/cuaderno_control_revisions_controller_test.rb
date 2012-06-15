require 'test_helper'

class CuadernoControlRevisionsControllerTest < ActionController::TestCase
  setup do
    @cuaderno_control_revision = cuaderno_control_revisions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuaderno_control_revisions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuaderno_control_revision" do
    assert_difference('CuadernoControlRevision.count') do
      post :create, cuaderno_control_revision: @cuaderno_control_revision.attributes
    end

    assert_redirected_to cuaderno_control_revision_path(assigns(:cuaderno_control_revision))
  end

  test "should show cuaderno_control_revision" do
    get :show, id: @cuaderno_control_revision
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cuaderno_control_revision
    assert_response :success
  end

  test "should update cuaderno_control_revision" do
    put :update, id: @cuaderno_control_revision, cuaderno_control_revision: @cuaderno_control_revision.attributes
    assert_redirected_to cuaderno_control_revision_path(assigns(:cuaderno_control_revision))
  end

  test "should destroy cuaderno_control_revision" do
    assert_difference('CuadernoControlRevision.count', -1) do
      delete :destroy, id: @cuaderno_control_revision
    end

    assert_redirected_to cuaderno_control_revisions_path
  end
end
