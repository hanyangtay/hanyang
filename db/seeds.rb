# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

password = "abcdef1!"

User.create!(name:  "Han Yang Tay",
             email: "htay@wesleyan.edu",
             password:              password,
             password_confirmation: password,
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             tagline: "I eat challenges.")
             
User.create!(name:  "Burnt Cactus",
             email: "guest@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             avatar: Rails.root.join("db/default/avatar_5.png").open,
             tagline: "Guest account for lazy people who refuse to sign up. ._.")
             
User.create!(name:  "Happy Amoeba ",
             email: "guest2@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             avatar: Rails.root.join("db/default/avatar_6.png").open,
             tagline: "Guest account for lazy people who refuse to sign up. ^.^")
             
User.create!(name:  "Stoned Fish",
             email: "guest3@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             avatar: Rails.root.join("db/default/avatar_7.png").open,
             tagline: "Guest account for lazy people who refuse to sign up. x.x")
             
User.create!(name:  "木漏れ日",
             email: "han1@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             tagline: "人生とは、一抹の泡みたいなものだ。")
             
User.create!(name:  "Sternenhimmel",
             email: "han2@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             tagline: "Es geht wieder los.")
             
User.create!(name:  "涟漪",
             email: "han3@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             tagline: "旅行需要目的地，而流浪需要终点。")

originalUsers = User.order(:created_at).take(7)
for i in 0..6
    user1 = originalUsers[i]
    for j in 0..6
        otherUser = originalUsers[j]
        user1.follow(otherUser) if i != j
    end
end  

User.create!(name:  Faker::Name.name,
             email: "test@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now)

20.times do |n|
    number = rand(6) + 1
    name  = Faker::Name.name
    email = "test-#{n}@han.io"
    User.create!(name:  name,
                   email: email,
                   password:              password,
                   password_confirmation: password,
                   activated: true,
                   activated_at: Time.zone.now,
                   avatar: Rails.root.join("db/default/avatar_#{number}.png").open)
    end

users = User.order(created_at: :desc).take(21)
users.each do |user|
    (rand(30)+1).times { user.status_posts.create!(
                                content: Faker::Lorem.sentence(rand(4) + 1),
                                created_at: rand(10.years).seconds.ago) }
    following = users.sample(rand(20))
    following.each { |followed| user.follow(followed) if followed.id != user.id }
end
