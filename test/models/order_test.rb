require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = orders(:order_one)
  end

  def teardown
    Rails.cache.clear
  end

  test 'order valid' do
    assert @order.valid?
  end

  test 'order invalid without order_number' do
    @order.order_number = nil
    refute @order.valid?, 'saved order without a order_number'
    assert_not_nil @order.errors[:order_number], 'no validation error for order_number present'
  end

  test 'order invalid without tracking_number' do
    @order.tracking_number = nil
    refute @order.valid?, 'saved order without a tracking_number'
    assert_not_nil @order.errors[:tracking_number], 'no validation error for tracking_number present'
  end

  test 'order invalid without address' do
    @order.address = nil
    refute @order.valid?, 'saved order without a address'
    assert_not_nil @order.errors[:address], 'no validation error for address present'
  end

  test 'order invalid without longitude' do
    @order.longitude = nil
    refute @order.valid?, 'saved order without a longitude'
    assert_not_nil @order.errors[:longitude], 'no validation error for longitude present'
  end

  test 'order invalid without latitude' do
    @order.latitude = nil
    refute @order.valid?, 'saved order without a latitude'
    assert_not_nil @order.errors[:latitude], 'no validation error for latitude present'
  end

  test 'order invalid without vendor' do
    @order.vendor = nil
    refute @order.valid?, 'saved order without a vendor'
    assert_not_nil @order.errors[:vendor], 'no validation error for vendor present'
  end

  test 'order invalid without buyer' do
    @order.buyer = nil
    refute @order.valid?, 'saved order without a buyer'
    assert_not_nil @order.errors[:buyer], 'no validation error for buyer present'
  end

  test 'order invalid without status' do
    @order.status = nil
    refute @order.valid?, 'saved order without a status'
    assert_not_nil @order.errors[:status], 'no validation error for status present'
  end

  test 'order has default status of Not Shipped when not shipped' do
    order = orders(:order_two)
    order.shipped_date = nil
    order.delivered_date = nil
    order.save
    assert_equal "Not Shipped", order.status, 'order status defaults to Not Shipped'
  end

  test 'order number must be six characters long' do
    @order.order_number = 11
    refute @order.valid?, 'order number must be six characters long'
  end

  test 'order number must be unique' do
    order2 = orders(:order_two)
    order2.order_number = @order.order_number
    refute order2.valid?, "Saved an order with the same order number"
  end

  test 'tracking number must be six characters long' do
    @order.tracking_number = 11
    refute @order.valid?, 'tracking number must be six characters long'
  end

  test 'tracking number must be unique' do
    order2 = orders(:order_two)
    order2.tracking_number = @order.tracking_number
    refute order2.valid?, "Saved an order with the same tracking number"
  end
end
