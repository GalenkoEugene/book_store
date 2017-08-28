ActiveAdmin.register Book do
  includes :authors, :category, :images
  permit_params :id, :category_id, :title, :price, :description, :materials, :height, :weight, :depth, :published_at, :active, author_ids: []
  form partial: 'form'

  index do
    selectable_column
    column :id
    column 'Images' do |book|
      book.images.map{|i| image_tag(i.file, size: '50x60') }.join.html_safe
    end
    column('Category') { |book| book.category.type_of }
    column :title
    column('Authors') { |book| authors_to_list(book) }
    column('Description') { |book| truncate(book.description, length: 75) }
    column :price
    column '' do |book|
      (link_to 'View', edit_admin_book_path(book)) + ' - ' +
      (link_to 'Delete', admin_book_path(book), method: :delete,
        data: { confirm: 'Are you sure you want to delete this items?' })
    end
  end

  form html: { multipart: true } do |f|
    f.inputs 'Resource Details' do
      f.input :title
      f.input :authors
      f.input :active
      f.input :price
      f.input :category, as: :select, collection:
        Category.pluck(:type_of, :id), include_blank: false
      f.input :description
      f.input :materials
      f.input :height
      f.input :weight
      f.input :depth
      f.input :published_at
      hint = f.object.images.map { |i| image_tag(i.file, size: '50x60') }
        .join.html_safe if f.object.images
      f.input :images, as: :file, required: true,
        input_html: { multiple: true}, hint: hint
    end
    f.actions
  end

  controller do
    def update(options = {}, &block)
      if params[:book].key?(:images)
        params[:book][:images].each do |img|
          @model = Book.find(params[:id]).images.new
          uploader = ImagesUploader.new(@model)
          uploader.store!(img)
          @model.update!(file: uploader.url)
        end
      end

      super do |success, failure|
        block.call(success, failure) if block
        failure.html { render :edit }
      end
    end
  end

  show do
    render 'admin/books/form', book: book
  end
end
