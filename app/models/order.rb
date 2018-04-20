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

  private

  def set_status
    if self.shipped_date? && self.delivered_date
      self.status = 'Delivered'
    elsif self.shipped_date?
      self.status = 'TBD'
    else
      self.status = 'Pending'
    end
  end

end
