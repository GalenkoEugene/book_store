class FixColumnNameInDeliveries < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :deliveries, :method, :name
  end

  def self.down
    rename_column :deliveries, :name, :method
  end
end
