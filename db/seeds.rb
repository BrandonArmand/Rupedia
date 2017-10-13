require 'faker'
Faker::UniqueGenerator.clear 

5.times do
  User.create!(
      username: Faker::Name.unique.name,
      email:    Faker::Internet.unique.email,
      password: Faker::Name.name,
      role: Faker::Number.between(0, 1)
  )
end
users = User.all

15.times do
    Wiki.create!(
        user: users.sample, 
        title: Faker::GameOfThrones.unique.character,
        body: Faker::Lorem.paragraphs(Faker::Number.between(1, 100)),
        private: Faker::Boolean.boolean
    ) 
end
wikis = Wiki.all

admin = User.create!(
    username: Faker::GameOfThrones.unique.character,
    email: 'admin@gmail.com',
    password: 'admin123',
    role: 'admin'
    )
5.times do
    Wiki.create!(
        user: admin, 
        title: Faker::GameOfThrones.unique.character,
        body: Faker::Lorem.paragraphs + Faker::Lorem.paragraphs + Faker::Lorem.paragraphs,
        private: Faker::Boolean.boolean
    ) 
end
    
User.create!(
    username: Faker::GameOfThrones.unique.character,
    email: 'premium@gmail.com',
    password: 'premium123',
    role: 'premium'
    )
    
User.create!(
    username: Faker::GameOfThrones.unique.character,
    email: 'user@gmail.com',
    password: 'user123',
    )

puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"

