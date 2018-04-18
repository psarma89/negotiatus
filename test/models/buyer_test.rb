require 'test_helper'

class BuyerTest < ActiveSupport::TestCase
  def setup
    @buyer = buyers(:buyer_one)
  end

  test 'buyer valid' do
    assert @buyer.valid?
  end

  test 'buyer invalid without name' do
    @buyer.name = nil
    refute @buyer.valid?, 'saved buyer without a name'
    assert_not_nil @buyer.errors[:name], 'no validation error for name present'
  end

  test 'buyer invalid without address' do
    @buyer.address = nil
    refute @buyer.valid?, 'saved buyer without a address'
    assert_not_nil @buyer.errors[:address], 'no validation error for address present'
  end

  test 'buyer invalid without longitude' do
    @buyer.longitude = nil
    refute @buyer.valid?, 'saved buyer without a longitude'
    assert_not_nil @buyer.errors[:longitude], 'no validation error for longitude present'
  end

  test 'buyer invalid without latitude' do
    @buyer.latitude = nil
    refute @buyer.valid?, 'saved buyer without a latitude'
    assert_not_nil @buyer.errors[:latitude], 'no validation error for latitude present'
  end

  test 'buyer name must be unique' do
    new_buyer = Buyer.new(@buyer.attributes)
    refute new_buyer.valid?, 'buyer company must be unique'
  end

  test 'buyer has many #orders' do
    assert_equal 1, @buyer.orders.size
  end

  test 'buyer has many #vendors thru orders' do
    assert_equal 1, @buyer.vendors.size
  end
end
