# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
data = File.read('thefile')

User.create!(name:  "Han Yang Tay",
             email: "htay@wesleyan.edu",
             password:              data,
             password_confirmation: data,
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Burnt Cactus",
             email: "guest@han.io",
             password:              data,
             password_confirmation: data,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Happy Amoeba ",
             email: "guest2@han.io",
             password:              data,
             password_confirmation: data,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Stoned Fish",
             email: "guest3@han.io",
             password:              data,
             password_confirmation: data,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "木漏れ日",
             email: "han1@han.io",
             password:              data,
             password_confirmation: data,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "es geht wieder los",
             email: "han2@han.io",
             password:              data,
             password_confirmation: data,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "涟漪",
             email: "han3@han.io",
             password:              data,
             password_confirmation: data,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Serendipity",
             email: "han4@han.io",
             password:              data,
             password_confirmation: data,
             activated: true,
             activated_at: Time.zone.now) 

User.create!(name:  "Musician",
             email: "han5@han.io",
             password:              data,
             password_confirmation: data,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Artist",
             email: "han6@han.io",
             password:              data,
             password_confirmation: data,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Dreamer",
             email: "han7@han.io",
             password:              data,
             password_confirmation: data,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Akasha",
             email: "han8@han.io",
             password:              data,
             password_confirmation: data,
             activated: true,
             activated_at: Time.zone.now)

originalUsers = User.order(:created_at).take(12)
for i in 0..11
    user1 = originalUsers[i]
    for j in 0..11
        otherUser = originalUsers[j]
        user1.follow(otherUser) if i != j
    end
end  

20.times do |n|
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

users = User.order(created_at: :desc).take(20)
users.each do |user|
    rand(20).times { user.status_posts.create!(
                                content: Faker::Lorem.sentence(rand(4) + 1),
                                created_at: rand(10.years).seconds.ago) }
    following = users.sample(rand(19))
    following.each { |followed| user.follow(followed) if followed.id != user.id }

end
