class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      t.string :method
      t.string :duration
      t.decimal :price, precision: 8, scale: 2
    end
  end
end
