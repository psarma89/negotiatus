class Order < ApplicationRecord
  belongs_to :vendor
  belongs_to :buyer
end
