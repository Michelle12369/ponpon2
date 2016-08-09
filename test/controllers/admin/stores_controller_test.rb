require 'test_helper'

class Admin::StoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_store = admin_stores(:one)
  end

  test "should get index" do
    get admin_stores_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_store_url
    assert_response :success
  end

  test "should create admin_store" do
    assert_difference('Admin::Store.count') do
      post admin_stores_url, params: { admin_store: {  } }
    end

    assert_redirected_to admin_store_url(Admin::Store.last)
  end

  test "should show admin_store" do
    get admin_store_url(@admin_store)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_store_url(@admin_store)
    assert_response :success
  end

  test "should update admin_store" do
    patch admin_store_url(@admin_store), params: { admin_store: {  } }
    assert_redirected_to admin_store_url(@admin_store)
  end

  test "should destroy admin_store" do
    assert_difference('Admin::Store.count', -1) do
      delete admin_store_url(@admin_store)
    end

    assert_redirected_to admin_stores_url
  end
end
