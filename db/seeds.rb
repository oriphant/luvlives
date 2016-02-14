require 'faker'

# u = User.find_or_initialize_by(
#   name: "Roberto Lee",
#   email: "oriphant@gmail.com",
# )
# u.password = "testtest"
# u.skip_confirmation!
# u.save!

2.times do
  u = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  u.skip_confirmation!
  u.save!
end

users = User.all

5.times do

  Question.create(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user: users.sample
  )

end

questions = Question.all

50.times do
  Answer.create(
    user: users.sample,
    question: questions.sample,
    body: Faker::Lorem.paragraph,
    created_at: Faker::Time.between(DateTime.now - 365, DateTime.now)
  )
end

answers = Answer.all
values = [1, -1]

500.times do
  Vote.create(
    user: users.sample,
    answer: answers.sample,
    value: values.sample
  )
end
