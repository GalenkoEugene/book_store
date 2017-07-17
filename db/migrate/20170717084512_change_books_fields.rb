class ChangeBooksFields < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up   do
        rename_column :books, :name, :title
        rename_column :books, :file, :img_url
        remove_column :books, :amount
      end

      dir.down do
        add_column    :books, :amount, :integer
        rename_column :books, :img_url, :file
        rename_column :books, :title, :name
      end
    end
  end
end
