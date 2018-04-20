require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get orders index" do
    get orders_url
    assert_response :success
    assert_equal "index", @controller.action_name
    assert_match "Orders", @response.body
  end

  test "Orders index should show stuff" do
    get orders_url
    assert_select "table", true
  end

  test "should get orders new page" do
    get new_order_url
    assert_response :success
    assert_equal "new", @controller.action_name
    assert_match "New Order", @response.body
  end

  test "should display form for creating order" do
    get new_order_url
    assert_select "form", true
    assert_select 'form input[type=submit]', true
    assert_select 'form input[id=order_order_number]', true
    assert_select 'form input[id=order_address]', true
    assert_select 'form select[id=order_vendor_id]', true
    assert_select 'form select[id=order_buyer_id]', true
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order:
        {
          order_number: rand(100000..999999),
          tracking_number: rand(100000..999999),
          vendor_id: Vendor.all.ids.sample,
          buyer_id: Buyer.all.ids.sample,
          address: doc.at_css("p").inner_text,
          shipped_date: DateTime.now,
          delivered_date: DateTime.now.next_day(rand(1..15))
        }
      }
    end

    assert_redirected_to articles_path
  end

end
