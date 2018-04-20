# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'nokogiri'
require 'open-uri'

include OrdersHelper

#Populate random buyers with random addresses using geocoder gem within US
def populate_buyer_data(buyer_count)
  i = 0
  while i < buyer_count do
    doc = Nokogiri::HTML(open("https://fakena.me/random-real-address/"))
    buyer = Buyer.new(name: Faker::Name.name, address: doc.at_css("p").inner_text)

    if buyer.save
      i+= 1
    end

  end
end

def populate_vendor_data(vendor_count)
  i = 0
  while i < vendor_count do
    doc = Nokogiri::HTML(open("https://fakena.me/random-real-address/"))
    vendor = Vendor.new(company: Faker::Company.name, address: doc.at_css("p").inner_text)

    if vendor.save
      i+= 1
    end

  end
end

def populate_order_data(order_count)
  i = 0
  while i < order_count do
    doc = Nokogiri::HTML(open("https://fakena.me/random-real-address/"))
    shipped_date = rand(1..4) != 2 ? DateTime.now.prev_day(rand(0..10)) : nil

    order = Order.new({
      order_number: rand(100000..999999),
      tracking_number: rand(100000..999999),
      vendor_id: Vendor.all.ids.sample,
      buyer_id: Buyer.all.ids.sample,
      address: doc.at_css("p").inner_text,
      shipped_date: shipped_date
    })

    order.delivered_date = order.shipped_date? && rand(1..4) != 2 ? DateTime.now.next_day(rand(1..10)) : nil

    if order.save
      i+= 1
    end

  end
end

populate_buyer_data(10)
populate_vendor_data(10)
populate_order_data(100)
