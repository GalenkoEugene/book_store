# frozen_string_literal: true

module BookHelper
  def authors
    @book.authors.map(&:name).join(', ')
  end

  def publication_year
    @book.published_at.year
  end

  def dimension
    "H:#{@book.height}\" x W:#{@book.weight}\"" \
    " x D:#{@book.depth}\", where ” - inches"
  end
end
