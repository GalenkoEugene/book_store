ActiveAdmin.register Book do
  active_admin_importable
  includes :authors, :category, :images
  permit_params :id, :category_id, :title, :price, :description, :materials, :height, :weight, :depth, :published_at, :active, author_ids: []

  index do
    selectable_column
    column I18n.t('admin.book.image') do |book|
      image_tag(book.images.last&.file&.thumb&.url || 'sample.jpg', size: '50x60')
    end
    column(I18n.t('admin.book.category')) { |book| book.category&.type_of }
    column :title
    column(I18n.t('admin.book.author')) { |book| authors_to_list(book) }
    column(I18n.t('admin.book.description')) do |book|
      truncate(book.description, length: 75)
    end
    column :price { |book| number_to_currency book.price }
    column do |book|
      (link_to I18n.t('admin.book.view'),
        edit_admin_book_path(book)) + ' - ' +
      (link_to I18n.t('admin.book.delete'),
        admin_book_path(book), method: :delete,
          data: { confirm: I18n.t('admin.book.confirm') })
    end
  end

  form html: { multipart: true } do |f|
    f.inputs I18n.t('admin.book.details') do
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
      hint = f.object.images.map { |i| image_tag(i.file.thumb.url) }
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
          @model.file.store!(img)
          @model.save!
        end
      end

      super do |success, failure|
        block.call(success, failure) if block
        render :edit and return
      end
    end
  end
end
