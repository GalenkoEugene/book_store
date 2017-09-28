class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :name
      t.string :mm_yy
      t.string :cvv
    end
  end
end
