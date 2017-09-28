class ChangeTypeForPublishedAtToBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :published_at, :data
    add_column :books, :published_at, :integer
  end
end

