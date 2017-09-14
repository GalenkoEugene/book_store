class ChangeNotNullColumnForCategoryIdOnBooks < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up   do
        change_column :books, :category_id, :bigint, null: true
      end

      dir.down do
        change_column :books, :category_id, :bigint, null: false
      end
    end
  end
end
