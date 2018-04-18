require 'test_helper'

class VendorTest < ActiveSupport::TestCase

  def setup
    @vendor = vendors(:vendor_one)
  end

  test 'vendor valid' do
    assert @vendor.valid?
  end

  test 'vendor invalid without company' do
    @vendor.company = nil
    refute @vendor.valid?, 'saved vendor without a company'
    assert_not_nil @vendor.errors[:company], 'no validation error for company present'
  end

  test 'vendor invalid without address' do
    @vendor.address = nil
    refute @vendor.valid?, 'saved vendor without a address'
    assert_not_nil @vendor.errors[:address], 'no validation error for address present'
  end

  test 'vendor invalid without longitude' do
    @vendor.longitude = nil
    refute @vendor.valid?, 'saved vendor without a longitude'
    assert_not_nil @vendor.errors[:longitude], 'no validation error for longitude present'
  end

  test 'vendor invalid without latitude' do
    @vendor.latitude = nil
    refute @vendor.valid?, 'saved vendor without a latitude'
    assert_not_nil @vendor.errors[:latitude], 'no validation error for latitude present'
  end

  test 'vendor name must be unique' do
    new_vendor = Vendor.new(@vendor.attributes)
    refute new_vendor.valid?, 'vendor company must be unique'
  end

  test 'vendor has many #orders' do
    assert_equal 2, @vendor.orders.size
  end

  test 'vendor has many #buyers thru orders' do
    assert_equal 2, @vendor.buyers.size
  end

end
