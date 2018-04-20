class AddOptimizationIndexToTables < ActiveRecord::Migration[5.1]
  def change
    add_index :orders, [:latitude, :longitude]
    add_index :buyers, [:latitude, :longitude]
    add_index :vendors, [:latitude, :longitude]
  end
end
