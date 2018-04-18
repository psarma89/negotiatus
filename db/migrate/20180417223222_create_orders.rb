class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :order_number
      t.integer :tracking_number
      t.integer :vendor_id
      t.integer :buyer_id
      t.string :status
      t.datetime :shipped_date
      t.datetime :delivered_date

      t.timestamps
    end
  end
end
