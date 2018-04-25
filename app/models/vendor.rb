require 'geocoder'

class Vendor < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :buyers, through: :orders

  # build an address from street, city, and state attributes
  geocoded_by :address

  # store the fetched address in the full_address attribute
  reverse_geocoded_by :latitude, :longitude, :address => :address

  validates :company, :address, :longitude, :latitude, presence: true

  validates :company, uniqueness: true

  before_validation :geocode, :reverse_geocode, if: :address_changed?
  # after_validation :geocode, :reverse_geocode, if: :address_changed?

  def delivered_orders
    self.orders.where("status = 'Delivered'")
  end

  def nearby_deliveries(order)
    delivered_orders_by_vendor = self.delivered_orders

    # See if any of the delivered are within 100 mile radius for a provided shipped but not delivered order
    format_deliviries(delivered_orders_by_vendor, order).select{ |f| f[:distance] < 100}
  end

  def all_deliveries(order)
    delivered_orders_by_vendor = self.delivered_orders

    # See if any of the delivered are within 100 mile radius for a provided shipped but not delivered order
    format_deliviries(delivered_orders_by_vendor, order)
  end

  def national_deliveries(order)
    all_vendor_deliveries = Order.all.where(status: 'Delivered')

    # See if any of the delivered are within 100 mile radius for a provided shipped but not delivered order
    format_deliviries(all_vendor_deliveries, order)
  end

  def format_deliviries(deliviries, order)
    deliviries.map { |delivered_order|
      tbd_lat_lng = [order.latitude, order.longitude]
      delivered_lat_lng = [delivered_order.latitude, delivered_order.longitude]
      {
        distance: Geocoder::Calculations.distance_between(tbd_lat_lng, delivered_lat_lng),
        time: delivered_order.delivered_date - delivered_order.shipped_date,
      }
    }
  end


end
