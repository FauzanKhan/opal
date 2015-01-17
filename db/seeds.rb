# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Tpo.create!(name:  "Example Tpo",
             email: "tpo@railstutorial.org",
             password:              "123123123",
             college: "IEC College of Engineering & Technology",
             admin: true)

50.times do |n|
  name  = Faker::Name.name
  email = "tpo-#{n+1}@railstutorial.org"
  password = "password"
  Tpo.create!(name:  name,
               email: email,
               password: password,
               college: college)
end

