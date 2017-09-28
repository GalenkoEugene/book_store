class ChangeBooksFields < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up   do
        rename_column :books, :name, :title
        remove_column :books, :file
        remove_column :books, :amount
      end

      dir.down do
        add_column    :books, :amount, :integer
        add_column    :books, :file, :string
        rename_column :books, :title, :name
      end
    end
  end
end
