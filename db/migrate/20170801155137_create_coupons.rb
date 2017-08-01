class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.decimal :value, precision: 8, scale: 2
    end
  end
end
