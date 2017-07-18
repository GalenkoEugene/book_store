# frozen_string_literal: true

require 'ffaker'

authors, books = [], []

15.times { authors << { name: FFaker::Book.author } }

35.times do
  books << {
    title: FFaker::Book.title,
    price: sprintf("%0.2f", rand(5..700.0)),
    description: FFaker::Book.description,
    published_at: rand(1600..2017),
    height: sprintf("%0.1f", rand(0..9.0)),
    weight: sprintf("%0.1f", rand(0..9.0)),
    depth: sprintf("%0.1f", rand(0..9.0)),
    materials: FFaker::Lorem.words(rand(1..5)).join(', ')
  }
end

authors_in_db = Author.create!(authors)
books.size.times { |item| authors_in_db.sample.books.create!(books[item]) }
