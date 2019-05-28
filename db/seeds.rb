User.create(email: "test@test.com", password: "password", password_confirmation: "password")
10.times do 
  Board.create(
    name: Faker::Name.first_name,
    user_id: 1
  )
end