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


7.times do |day|
  halls.each do |hall|
    Seance.where(movie: Movie.all.sample, hall: hall, price: 15, start_time: Time.zone.now + day.days).first_or_create!
  end
end

seances = Seance.all
seances.each do |seance|
  Reservation.where(seance: seance, email: 'user@example.com').first_or_create!.tap do |reservation|
      Ticket.create(seat: 1, reservation: reservation)
      Ticket.create(seat: 2, reservation: reservation)
  end
end

5.times do |i|
  User.where(email: "client#{i}@example.com", password:'password').first_or_create!
end

User.where(email: 'manager@example.com', password:'password').first_or_create!
