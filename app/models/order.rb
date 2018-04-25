class Order < ApplicationRecord

  belongs_to :vendor
  belongs_to :buyer

  # build an address from street, city, and state attributes
  geocoded_by :address

  # store the fetched address in the full_address attribute
  reverse_geocoded_by :latitude, :longitude, :address => :address

  validates :order_number, :tracking_number, :vendor, :buyer, :status, :address, :longitude, :latitude, presence: true
  validates :order_number, :tracking_number, uniqueness: true, length: { is: 6 }

  before_validation :set_status, :geocode, :reverse_geocode, if: :address_changed?

  def self.filter_by_status(filter)
    where("status = ?", filter)
  end

  def set_status
    if self.shipped_date? && self.delivered_date?
      self.status = 'Delivered'
    elsif self.shipped_date?
      self.status = self.shipped_status
    else
      self.status = 'Not Shipped'
    end
  end

  def shipped_status
    # Find all delivered orders for the Vendor on this shipped but not delivered order
    nearby_deliveries = self.vendor.nearby_deliveries(self)
    all_deliveries = self.vendor.all_deliveries(self)
    national_deliveries = self.vendor.national_deliveries(self)

    if nearby_deliveries.any?
      # Calculate if delivery is "Normal", "Not Normal", or "Very Late" using nearby deliviries for vendor
      self.calculate_status(nearby_deliveries)
    elsif all_deliveries.any?
      # Calculate if delivery is "Normal", "Not Normal", or "Very Late" using all deliviries for vendor
      self.calculate_status(all_deliveries)
    else
      # Calculate if delivery is "Normal", "Not Normal", or "Very Late" using all deliviries nationally
      self.calculate_status(national_deliveries)
    end


  end

  def calculate_status(deliveries)
    avg_delivery_time = deliveries.reduce(0){|sum, delivery| sum + delivery[:time]}
    elapsed_time = Time.now - self.shipped_date

    #threshold for being Not Normal, three days delayed from average delivery time
    three_days_seconds = (24*3*3600)

    # Status is normal if elapsed time is less than average delivery time
    if elapsed_time <= avg_delivery_time
      self.status = 'Normal'
    elsif elapsed_time > avg_delivery_time && elapsed_time <= avg_delivery_time + three_days_seconds
      self.status = "Not Normal"
    else
      # Very late for delivery after 3 days from average
      self.status = "Very Late"
    end

  end

end
