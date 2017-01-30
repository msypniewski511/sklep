require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  include CurrentCart
  setup do
    @order = orders(:one)
  end

  test "requires item in the cart" do
    get new_order_url
    assert_response :redirect
    assert_redirected_to store_url
    assert_equal flash[:notice], 'Your cart is empty'
  end
 
  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    post line_items_url, params: { product_id: products(:ruby).id}
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    @cart = Cart.create
    assert_difference('Order.count') do
      post orders_url, order: { id: @cart.id, address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type }
    end
  end


  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order), params: {orders: {:id => @order.id} }
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type } 
    assert_response :redirect
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
