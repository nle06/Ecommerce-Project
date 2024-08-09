require 'faker'

# Clear existing records
Product.destroy_all
Category.destroy_all

# Create Categories
categories = Category.create([
  { name: 'Laptops' },
  { name: 'Smartphones' },
  { name: 'Tablets' },
  { name: 'Accessories' }
])

# Create Products
100.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    price: Faker::Commerce.price(range: 100.0..1500.0),
    stock_quantity: Faker::Number.between(from: 10, to: 100),
    category: categories.sample,
    on_sale: Faker::Boolean.boolean,
    sale_price: Faker::Commerce.price(range: 50.0..1400.0)
  )
end

# Create Admin User
AdminUser.find_or_create_by!(email: 'lephun1@gmail.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end

# Seed Pages
Page.find_or_create_by!(title: 'About Us') do |page|
  page.content = 'Initial content for About Us page'
end

Page.find_or_create_by!(title: 'Contact Us') do |page|
  page.content = 'Initial content for Contact Us page'
end

puts "Seeded #{Category.count} categories, #{Product.count} products, and admin user."
