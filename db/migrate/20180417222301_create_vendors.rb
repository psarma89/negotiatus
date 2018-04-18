class CreateVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :vendors do |t|
      t.string :company
      t.string :address
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
