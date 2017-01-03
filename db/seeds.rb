User.create! name: "User 1", email: "user1@gmail.com",
  password: "123123", password_confirmation: "123123",
  is_admin: true, avatar: "avatar.jpg",
             activated: true,
             activated_at: Time.zone.now
User.create! name: "User 2", email: "user2@gmail.com",
             password: "123123", password_confirmation: "123123",
             is_admin: false, avatar: "avatar.jpg",
             activated: false,
             activated_at: Time.zone.now
20.times do |n|
  _name = Faker::Name.name
  _pass = "123123"
  _email = "example-#{n+1}@railstutorial.org"
  User.create! name: _name, email: _email,
    password: _pass, password_confirmation: _pass,
    is_admin: false, avatar: "avatar.jpg",
    activated: true,
    activated_at: Time.zone.now
end

Category.create!(name: "Animals and Pets")
Category.create!(name: "Business")
Category.create!(name: "Cooking, Food and Drink")
Category.create!(name: "Fiction")
Category.create!(name: "Gardening")
Category.create!(name: "History")
Category.create!(name: "Kids")
Category.create!(name: "Science and Nature")
Category.create!(name: "The Arts")
Category.create!(name: "Travel")
Category.create!(name: "Teens and YA")
Category.create!(name: "Poetry")

categories = Category.order(:created_at).take(12)
publish_date = "2012-10-01"
categories.each do |category|
  8.times do
    description = Faker::Lorem.paragraph
    author = Faker::Name.name
    title = Faker::Name.name
    image = "book1.jpg"
    category.books.create!(description: description, title: title,
      publish_date: publish_date, author: author, page: 100, image: image)
  end
end
