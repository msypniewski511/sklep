require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "requires item in the cart" do
    get :new
    assert_response :redirect
    assert_redirected_to store_url
    assert_equal flash[:notice], 'Your cart is empty.'
  end
 
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    item = LineItem.new
    item.build_cart
    item.product = products(:ruby)
    item.save!
    session[:cart_id] = item.cart.id
    get :new
    assert_response :success
  end

  test "should create order" do
    cart = Cart.create
    session[:cart_id] = cart.id
    assert_difference('Order.count') do
      post :create, params: { order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type } }
    end

    assert_redirected_to store_path
  end

  test "should show order" do
    get :show, params: {:id => @order.id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: {:id => @order.id }
    assert_response :success
  end

  test "should update order" do
    post :update, id: @order, order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type } 
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_url
  end
end
