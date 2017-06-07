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
            first_name: first_name, last_name: last_name, is_admin: is_admin)

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

# Create Exit Ticket
title = "Exit Ticket Template"
description = "To find out how you are doing in class"
user = User.first

FormTemplate.create(title: title, description: description, user: user)

label = "My instructor(s) was effective in helping me achieve the learning objectives of the class."
qns_type = 2
options = ""
form_template = FormTemplate.first

Question.create(form_template: form_template, qns_type: qns_type, label: label, options: options)

label = "The lesson was well-planned and sufficient time was given for each activity."
qns_type = 2
options = ""
form_template = FormTemplate.first

Question.create(form_template: form_template, qns_type: qns_type, label: label, options: options)

label = "I found the learning objectives useful and I understand how it fits into the bigger picture of web development "
qns_type = 2
options = ""
form_template = FormTemplate.first

Question.create(form_template: form_template, qns_type: qns_type, label: label, options: options)

label = "Any other comments or suggestions to improve the learning experience? Feel free to let us know what you enjoyed about it as well!"
qns_type = 3
options = ""
form_template = FormTemplate.first

Question.create(form_template: form_template, qns_type: qns_type, label: label, options: options)

label = "Any questions about the learning objectives you would like the instructor to help clarify for you?"
qns_type = 3
options = ""
form_template = FormTemplate.first

Question.create(form_template: form_template, qns_type: qns_type, label: label, options: options)

title = "Exit Ticket Week 6 Day 4"
description = "To find out how students are doing"
user = User.first
form_template = FormTemplate.first
form_date = Faker::Date.forward(1)

Form.create(title: title, description: description, user: user, form_template: form_template, form_date: form_date)

# Additional Data!
#Creating a Form_Template
20.times do
  title = Faker::HarryPotter.quote
  description = Faker::HarryPotter.quote + Faker::HarryPotter.quote
  offset = rand(User.count)
  user = User.offset(offset).limit(1).first

  FormTemplate.create(title: title, description: description, user: user)
end

# Creating Questions
40.times do
  label = Faker::HarryPotter.quote
  qns_type = Faker::Number.between(1, 1)
  options = Faker::HarryPotter.quote + Faker::HarryPotter.quote
  offset = rand(FormTemplate.count)
  form_template = FormTemplate.offset(offset).limit(2).last

  Question.create(form_template: form_template, qns_type: qns_type, label: label, options: options)
end

# Creating Form
20.times do
  title = Faker::HarryPotter.quote
  description = Faker::HarryPotter.quote + Faker::HarryPotter.quote
  offset = rand(User.count)
  user = User.offset(offset).limit(1).first
  offset = rand(FormTemplate.count)
  form_template = FormTemplate.offset(offset).limit(1).first
  form_date = Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today)

  Form.create(title: title, description: description, user: user, form_template: form_template, form_date: form_date)
end

# Creating Answers
40.times do
  content = Faker::HarryPotter.quote
  offset = rand(User.count)
  user = User.offset(offset).limit(1).first
  offset = rand(Form.count)
  form = Form.offset(offset).limit(2).last
  offset = rand(Question.count)
  question = Question.offset(offset).limit(2).last

  Answer.create(content: content, user: user, form: form, question: question)
end
