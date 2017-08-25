module BookHelper
  def dimension_for(book)
    "H:#{book.height}\" x W:#{book.weight}\"" \
    " x D:#{book.depth}\", where ” - inches"
  end

  def group_by4in_row(books)
    set = ''
    a = books.in_groups_of(4) do |group|
      set << '<div class = "row"> '
      group.each do |book|
        set << (render partial: 'books/book', locals: { book: book }) unless book.nil?
      end
      set << ' </div>'
    end
    set.html_safe
  end

  def active_filter
    case request.GET[:filter]
    when 'popular' then t('button.popular_first')
    when 'price_up' then t('button.low_to_hight')
    when 'price_down' then t('button.hight_to_low')
    when 'a_z' then t('button.title_A-Z')
    when 'z_a' then t('button.title_Z-A')
    else
      t('button.newest_first')
    end
  end

  def img_of(book)
    book.images&.first&.file || default_image
  end

  private

  def default_image
    'sample.jpg'
  end
end
