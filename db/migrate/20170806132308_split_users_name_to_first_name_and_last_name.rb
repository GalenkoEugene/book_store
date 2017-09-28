class SplitUsersNameToFirstNameAndLastName < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up   do
        remove_column :users, :name
        add_column :users, :first_name, :string
        add_column :users, :last_name, :string
      end

      dir.down do
        add_column    :users, :name, :string
        remove_column :users, :first_name
        remove_column :users, :last_name
      end
    end
  end
end
