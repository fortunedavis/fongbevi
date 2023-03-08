# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create!(
  email: "admin@gmail.com",
  password: "adminadmin",
  fullname: "Super Admin",
  country: "Bénin",
  role: 2
)

User.create!(
  email: "first@gmail.com",
  password: "firstfirst",
  fullname: "Admin",
  country: "Bénin",
  role: 2
)

Sentence.create!([{
  content: "Ne regardez pas le livre",
  user_id: user.id
},
{
 content:"Vous pouvez m’aider ?",
 user_id: user.id
},
{
  content:"Vous avez 10 minutes pour faire le test.",
  user_id: user.id
},
{
  content:"À la semaine prochaine", 
  user_id: user.id
}
])
p "Welcome Fortuné #{Sentence.count} Sentences has been Created. Good Journey!!!"
