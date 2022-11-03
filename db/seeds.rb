# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Sentence.create!([{
  content: "Ne regardez pas le livre",
},
{
 content:"Vous pouvez m’aider ?"
},
{
  content:"Vous avez 10 minutes pour faire le test."
},
{
  content:"À la semaine prochaine"
}
])
p "Created #{Sentence.count} Phrases"
