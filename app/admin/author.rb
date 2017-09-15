ActiveAdmin.register Author do
  active_admin_importable
  permit_params :name
  includes :author_books, :books

  index do
    selectable_column
    id_column
    column :name
    column '' do |author|
      (link_to 'Edit', edit_admin_author_path(author)) + ' - ' +
      (link_to 'Delete', admin_author_path(author), method: :delete,
        data: { confirm:
          'Are you sure you want to delete this items?'\
          "\nThey are associated with #{author.books.count} of books"
        })
    end
  end

  filter :name, as: :select
  filter :books_title, as: :select, collection: Book.all
end
