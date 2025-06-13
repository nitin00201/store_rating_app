puts "Seeding database..."

User.destroy_all
Store.destroy_all
Rating.destroy_all

# Admin
admin = User.create!(
  name: "Administrator Account",
  email: "admin@example.com",
  address: "Admin HQ, India",
  password: "Admin@123",
  password_confirmation: "Admin@123",
  role: "admin"
)

puts "Admin created"

# Store Owners
owner1 = User.create!(
  name: "Alice Storeowner India",
  email: "alice@store.com",
  address: "123 Market St, Delhi",
  password: "Store@123",
  password_confirmation: "Store@123",
  role: "store_owner"
)

owner2 = User.create!(
  name: "Bob Storeowner Mumbai",
  email: "bob@store.com",
  address: "456 Mall Rd, Mumbai",
  password: "Store@123",
  password_confirmation: "Store@123",
  role: "store_owner"
)

puts "Store owners created"

# Stores
store1 = Store.create!(
  name: "Alice's Flower Shop",
  email: "flowers@alice.com",
  address: "123 Bloom Lane, Delhi",
  user: owner1
)

store2 = Store.create!(
  name: "Bob's Bookstore",
  email: "books@bob.com",
  address: "456 Read Blvd, Mumbai",
  user: owner2
)

puts "Stores created"

# Normal Users
users = []
3.times do |i|
  users << User.create!(
    name: "Normal User Example #{i+1}",
    email: "user#{i+1}@mail.com",
    address: "User Street #{i+1}, India",
    password: "User@123",
    password_confirmation: "User@123",
    role: "normal_user"
  )
end

puts "Normal users created"

# Ratings
Rating.create!(user: users[0], store: store1, value: 5)
Rating.create!(user: users[1], store: store1, value: 4)
Rating.create!(user: users[2], store: store2, value: 3)
Rating.create!(user: users[0], store: store2, value: 2)

puts "Ratings created"
puts "✅ Seed data loaded successfully!"
