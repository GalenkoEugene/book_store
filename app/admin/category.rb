ActiveAdmin.register Category, as: 'BookCategory' do
  permit_params :type_of
  includes :books

  index do
    selectable_column
    id_column
    column 'Name', :type_of
    column '' do |category|
      (link_to 'Edit', edit_admin_book_category_path(category)) + ' - ' +
      (link_to 'Delete', admin_book_category_path(category), method: :delete,
        data: { confirm:
          'Are you sure you want to delete this items?'\
          "\nThey are associated with #{category.books.count} of books"
        })
    end
  end
end
