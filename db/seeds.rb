# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def test_data
  @user1 = User.create(name: "CandyLand", email: "Bungie123@gmail.com", password: "Hello123!", password_confirmation: "Hello123!")
  @user2 = User.create(name: "Macbeth", email: "Blurp@gmail.com", password: "Hello123!", password_confirmation: "Hello123!")
  @user3 = User.create(name: "Jerry", email: "Moogoo@gmail.com", password: "Hello123!", password_confirmation: "Hello123!")

  # @movie1 = Movie.create(id: 2, title: "Ariel", runtime: 73, tmdb_id: 2)
  # @movie2 = Movie.create(id: 3, title: "Shadows in Paradise", runtime: 74, tmdb_id: 3)
  # @movie3 = Movie.create(id: 5, title: "Four Rooms ", runtime: 98, tmdb_id: 5)

  # @party1 = Party.create(duration: 200, name: "Ariel", date: "January 1, 2024", start_time: "6:00 pm", movie_id: @movie1.id)
  # @party2 = Party.create(duration: 100, name: "Shadows in Paradise", date: "October 2, 2025", start_time: "2:00 pm", movie_id: @movie2.id)
  # @party3 = Party.create(duration: 98, name: "Four Rooms ", date: "July 15, 2026", start_time: "5:00 pm", movie_id: @movie3.id)

  # @userparty1 = UserParty.create(user_id: @user1.id, party_id: @party1.id, creator: true)
  # @userparty2 = UserParty.create(user_id: @user2.id, party_id: @party1.id, creator: false)

end