10.times do
  User.create(username: Faker::Name.name,
              email: Faker::Internet.email,
              password: Faker::Internet.password)
end

20.times do
  Category.create(name: Faker::Commerce.department)
end

100.times do |i|
  Idea.create(title: Faker::Hacker.noun,
              description: Faker::Hacker.say_something_smart,
              category_id: Category.all[i%20].id,
              user_id: User.all[i%10].id)
end
