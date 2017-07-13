# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :file
      t.decimal :price, precision: 8, scale: 2
      t.integer :amount
      t.text :description
      t.date :published_at
      t.string :dimension
      t.string :materials

      t.timestamps
    end
  end
end
