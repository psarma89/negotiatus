class ModifyOrdersTable < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :order_number, :integer, limit: 6
    change_column :orders, :tracking_number, :integer, limit: 6
    add_column :orders, :address, :string
    add_column :orders, :latitude, :float
    add_column :orders, :longitude, :float        
  end
end
