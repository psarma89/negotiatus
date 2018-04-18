class Vendor < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :buyers, through: :orders

  # build an address from street, city, and state attributes
  geocoded_by :address

  # store the fetched address in the full_address attribute
  reverse_geocoded_by :latitude, :longitude, :address => :address

  validates :company, :address, :longitude, :latitude, presence: true

  validates :company, uniqueness: true

  before_validation :geocode, :reverse_geocode
  after_validation :geocode, :reverse_geocode, if: :address_changed?

end
