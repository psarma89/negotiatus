require 'test_helper'

class VendorTest < ActiveSupport::TestCase

  def setup
    @vendor = vendors(:one)
  end

  test 'vendor valid' do
    assert @vendor.valid?
  end

  test 'vendor invalid without company' do
    @vendor.company = nil
    refute @vendor.valid?, 'saved vendor without a company'
  end

  test 'vendor invalid without address' do
    @vendor.address = nil
    refute @vendor.valid?, 'saved vendor without a address'
  end

  test 'vendor invalid without longitude' do
    @vendor.longitude = nil
    refute @vendor.valid?, 'saved vendor without a longitude'
  end

  test 'vendor invalid without latitude' do
    @vendor.latitude = nil
    refute @vendor.valid?, 'saved vendor without a latitude'
  end

  test 'vendor name must be unique' do
    new_vendor = Vendor.new(@vendor.attributes)
    refute new_vendor.valid?, 'vendor company must be unique'
  end

  test 'vendor has many #orders' do
    assert_equal 2, @vendor.orders.size
  end

end
