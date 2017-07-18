class AddHeightWeightDepthToBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :dimension, :string

      change_table :books do |t|
        t.decimal :height, precision: 4, scale: 1
        t.decimal :weight, precision: 4, scale: 1
        t.decimal :depth, precision: 4, scale: 1
      end

  end
end
