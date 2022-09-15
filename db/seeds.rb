# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
[200, 100, 100, 100, 100, 50, 50, 50, 50, 20].each_with_index do |capacity, index|
  Hall.where(capacity: capacity, name: "Hall #{index+1}").first_or_create!
end

10.times do
  Movie.where(title: Faker::Movie.title, length: [100, 120, 90].sample).first_or_create!
end
