ActiveAdmin.register Book do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
# permit_params :id, :title, :category_id, :published, :price, :description, :materials,
# :height, :width, :depth
  includes :authors, :category
  permit_params :category_id, :title, :price, :description, :materials, :height, :weight, :depth, :published_at, :active, author_ids: []
  form partial: 'form'

  index do
    selectable_column
    column :id
    # column :image
    column('Category') { |book| book.category.type_of }
    column :title
    column('Authors') { |book| authors_to_list(book) }
    column('Description') { |book| truncate(book.description, length: 75) }
    column :price
    column '' do |book|
      (link_to 'View', edit_admin_book_path(book)) + ' - ' +
      (link_to 'Delete', admin_book_path(book), method: :delete, data: { confirm: 'Are you sure you want to delete this items?' })
    end
  end

  show do
    render 'admin/books/form', book: book
  end
end
