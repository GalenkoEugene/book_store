# frozen_string_literal: true

module BookHelper
  def dimension_for(book)
    "H:#{book.height}\" x W:#{book.weight}\"" \
    " x D:#{book.depth}\", where ” - inches"
  end
end
