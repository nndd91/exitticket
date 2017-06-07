# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create first admin user
email = "demo@demo.com"
password = "password"
first_name = "Demo"
last_name = Faker::Name.last_name
username = "Demo"
is_admin = true

User.create(username: username, email: email, password: password, password_confirmation: password,
            first_name: first_name, last_name: last_name)

# Creating Remaining Users
20.times do
  username = Faker::Internet.user_name
  email = Faker::Internet.email
  password = "password"
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(username: username, email: email, password: password, password_confirmation: password,
              first_name: first_name, last_name: last_name)
end

#Creating a Form_Template
20.times do
  title = Faker::HarryPotter.quote
  description = Faker::HarryPotter.quote + Faker::HarryPotter.quote
  offset = rand(User.count)
  user = User.offset(offset).limit(1).first

  FormTemplate.create(title: title, description: description, user: user)
end
