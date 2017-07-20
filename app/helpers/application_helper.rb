# frozen_string_literal: true

module ApplicationHelper
  def authors_to_list(book)
    book.authors.map(&:name).join(', ')
  end
end
