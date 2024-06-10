# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#require "faker"

#676.times do
#    Product.create(
#        title: Faker::Commerce.product_name,
#        price: Faker::Commerce.price,
#        stock_quantity: Faker::Number.between(from: 1, to: 100)
#    )
#end


require "csv"

# clear existing data
Product.destroy_all
Category.destroy_all

# Set path to csv
csv_file = Rails.root.join('db/products.csv')

# Read the csv
csv_data = File.read(csv_file)

# Parse the csv
products = CSV.parse(csv_data, headers: true)

# Loop through each product
products.each do |product|
    category_name = product['category_name']

    category = Category.find_or_create_by(name: category_name)

    Product.create(
        title: product['name'],
        price: product['price'],
        description: product['description'],
        stock_quantity: ['stock quantity'],
        category: category
    )
end

puts "Created #{Category.count} categories."
puts "Created #{Product.count} products."
