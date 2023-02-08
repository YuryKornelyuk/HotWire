# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

20.times do
  Image.create title: FFaker::Name.last_name, url: FFaker::Image.url
end

20.times do
  Folder.create title: FFaker::CheesyLingo.word,
                description: FFaker::Lorem.sentence
end
