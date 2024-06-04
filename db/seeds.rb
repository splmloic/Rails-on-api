# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"
User.destroy_all
Article.destroy_all
5.times do |count|
    User.create!(
        email: "admin#{count+1}@gmail.com" ,
        password: "admin"
    )

end
30.times do
    Article.create!(
        title: Faker::Quote.most_interesting_man_in_the_world,
        content: Faker::TvShows::BojackHorseman.quote,
        user: User.order('RANDOM()').first
    )
end