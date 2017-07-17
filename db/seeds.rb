# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

authors_ex = [
  { name: 'Scott Fitzgerald' },
  { name: 'John Steinbeck' },
  { name: 'George Orwell' },
  { name: 'James Joyce' }
]

books_ex = [
    [ { title: 'The Grapes of Wrath', img_url: 'path_to.png', price: 15.20, description: "In my younger and more vulnerable years my father gave me some advice that I've been turning over in my mind ever since.", published_at: Time.now.years_ago(15), dimension: 'H:6.4\" x W: 0.9\" x D: 5.0', materials: 'Hardcove, glossy paper' },
      { title: 'The Grapes of Wrath2', img_url: 'path_to2.png', price: 15.20, description: "2 In my younger and more vulnerable years my father gave me some advice that I've been turning over in my mind ever since. 2", published_at: Time.now.years_ago(15), dimension: '2 4.37 x 7 inches (178 x 111mm) 2', materials: '2 paper 2' }
      ],

  { title:'The Great Gatsby', img_url: 'path_to.jpeg', price: 23.14, description: "To the red country and part of the gray country of Oklahoma, the last rains came gently, and they did not cut the scarred earth.", published_at: Time.now.years_ago(7), dimension: 'H:6.4\" x W: 0.9\" x D: 5.0', materials: 'Hardcove, glossy paper' },

  { title:'Nineteen Eighty-Four', img_url: 'path_to.jpg', price: 700.00, description: 'It was a bright cold day in April, and the clocks were striking thirteen.', published_at: Time.now.years_ago(35), dimension: '5×7 inches (178 x 127mm)', materials: 'leather' },

  { title:'Ulysses', img_url: 'path_to.jpg', price: 63.75, description: 'Stately, plump Buck Mulligan came from the stairhead, bearing a bowl of lather on which a mirror and a razor lay crossed.', published_at: Time.now.years_ago(6), dimension: '5 x 8 inches (203 x 127mm)', materials: 'paper' }
]

Author.delete_all
Book.delete_all
AuthorBook.delete_all

Author.create(authors_ex)
4.times do |item|
 Author.find_by_name(authors_ex[item][:name]).books.create(books_ex[item])
end
