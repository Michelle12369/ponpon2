require 'test_helper'

class Admin::CouponsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_coupon = admin_coupons(:one)
  end

  test "should get index" do
    get admin_coupons_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_coupon_url
    assert_response :success
  end

  test "should create admin_coupon" do
    assert_difference('Admin::Coupon.count') do
      post admin_coupons_url, params: { admin_coupon: {  } }
    end

    assert_redirected_to admin_coupon_url(Admin::Coupon.last)
  end

  test "should show admin_coupon" do
    get admin_coupon_url(@admin_coupon)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_coupon_url(@admin_coupon)
    assert_response :success
  end

  test "should update admin_coupon" do
    patch admin_coupon_url(@admin_coupon), params: { admin_coupon: {  } }
    assert_redirected_to admin_coupon_url(@admin_coupon)
  end

  test "should destroy admin_coupon" do
    assert_difference('Admin::Coupon.count', -1) do
      delete admin_coupon_url(@admin_coupon)
    end

    assert_redirected_to admin_coupons_url
  end
end
