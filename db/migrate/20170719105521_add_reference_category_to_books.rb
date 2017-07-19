class AddReferenceCategoryToBooks < ActiveRecord::Migration[5.1]
  def change
    change_table(:books) do |t|
      t.belongs_to :category, foreign_key: true, null: false
    end
  end
end
