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
             avatar: Rails.root.join("db/default/avatar.png").open,
             tagline: "I eat challenges.")
             
User.create!(name:  "木漏れ日",
             email: "han1@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             avatar: Rails.root.join("db/default/avatar.png").open,
             tagline: "人生とは、一抹の泡みたいなものだ。")
             
User.create!(name:  "Sternenhimmel",
             email: "han2@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             avatar: Rails.root.join("db/default/avatar.png").open,
             tagline: "Es geht wieder los.")
             
User.create!(name:  "涟漪",
             email: "han3@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             avatar: Rails.root.join("db/default/avatar.png").open,
             tagline: "旅行需要目的地，而流浪需要终点。")

originalUsers = User.order(:created_at).take(4)
for i in 0..3
    user1 = originalUsers[i]
    for j in 0..3
        otherUser = originalUsers[j]
        user1.follow(otherUser) if i != j
    end
end  

             
User.create!(name:  "Burnt Cactus",
             email: "guest@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             avatar: Rails.root.join("db/default/avatar_5.png").open,
             tagline: "Guest account for lazy people who refuse to sign up. ._.",
             guest: true)
             
User.create!(name:  "Happy Amoeba ",
             email: "guest2@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             avatar: Rails.root.join("db/default/avatar_6.png").open,
             tagline: "Guest account for lazy people who refuse to sign up. ^.^",
             guest: true)
             
User.create!(name:  "Stoned Fish",
             email: "guest3@han.io",
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now,
             avatar: Rails.root.join("db/default/avatar_7.png").open,
             tagline: "Guest account for lazy people who refuse to sign up. x.x",
             guest: true)

10.times do |n|
    number = rand(6) + 1
    name  = Faker::Name.name
    email = "test-#{n}@han.io"
    User.create!(name:  name,
                   email: email,
                   password:              password,
                   password_confirmation: password,
                   activated: true,
                   activated_at: Time.zone.now,
                   avatar: Rails.root.join("db/default/avatar_#{number}.png").open,
                   tagline: "I'm not real. Just here to take up space.")
    end

users = User.order(created_at: :desc).take(13)
users.each do |user|
    (rand(20)+1).times { user.status_posts.create!(
                                content: Faker::Lorem.sentence(rand(4) + 1),
                                created_at: rand(10.years).seconds.ago) }
    following = users.sample(rand(12))
    following.each { |followed| user.follow(followed) if followed.id != user.id }
end


users.each do |user|
    following_users = user.following.all
    following_users.each do |user_2|    
        if user.id != user_2.id
            statusposts = user_2.status_posts.all
            like_posts = statusposts.sample(rand(statusposts.count))
            like_posts.each { |post| user.like(post)}
            

            quote_posts = statusposts.sample(rand(5))
            quote_posts.each do |post| 
                user.status_posts.create!(content: post.content, repost_id: post.id,
                                        created_at: rand(post.created_at..Time.now))

            end
        end
    end
end
