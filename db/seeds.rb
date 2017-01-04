# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Han Yang Tay",
             email: "htay@wesleyan.edu",
             password:              "abcdef1!",
             password_confirmation: "abcdef1!",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
             
             
User.create!(name:  "Boss",
             email: "guest@han.io",
             password:              "abcdef1!",
             password_confirmation: "abcdef1!",
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Pal",
             email: "guest2@han.io",
             password:              "abcdef1!",
             password_confirmation: "abcdef1!",
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Friend",
             email: "guest3@han.io",
             password:              "abcdef1!",
             password_confirmation: "abcdef1!",
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Musician",
             email: "han1@han.io",
             password:              "abcdef1!",
             password_confirmation: "abcdef1!",
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Artist",
             email: "han2@han.io",
             password:              "abcdef1!",
             password_confirmation: "abcdef1!",
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Observer",
             email: "han3@han.io",
             password:              "abcdef1!",
             password_confirmation: "abcdef1!",
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Chef",
             email: "han4@han.io",
             password:              "abcdef1!",
             password_confirmation: "abcdef1!",
             activated: true,
             activated_at: Time.zone.now) 

User.create!(name:  "Human",
             email: "han5@han.io",
             password:              "abcdef1!",
             password_confirmation: "abcdef1!",
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Explorer",
             email: "han6@han.io",
             password:              "abcdef1!",
             password_confirmation: "abcdef1!",
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Dreamer",
             email: "han7@han.io",
             password:              "abcdef1!",
             password_confirmation: "abcdef1!",
             activated: true,
             activated_at: Time.zone.now)
             
             
             

50.times do |n|
    name  = Faker::Name.name
    email = Faker::Internet.email
    password = "abcdef1!"
    User.create!(name:  name,
                   email: email,
                   password:              password,
                   password_confirmation: password,
                   activated: true,
                   activated_at: Time.zone.now)
    end
    
    users = User.order(created_at: :desc).take(50)
    50.times do
        content = Faker::Lorem.sentence(5)
        users.each { |user| user.status_posts.create!(content: content,
                                    created_at: rand(10.years).seconds.ago) }
end