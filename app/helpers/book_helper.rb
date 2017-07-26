
module BookHelper
  def dimension_for(book)
    "H:#{book.height}\" x W:#{book.weight}\"" \
    " x D:#{book.depth}\", where ” - inches"
  end

  def group_by4in_row(books)
    set = ''
    books.in_groups_of(4) do |group|
      set << '<div class = "row"> '
      group.each do |book|
        set << (render partial: 'books/book', locals: { book: book }) unless book.nil?
      end
      set << ' </div>'
    end
    set.html_safe
  end
end
