# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

require 'csv'

filepath = Rails.root.join('db','products.csv')

CSV.foreach(filepath, headers: true) do |row|
  categories = row['categories'].split(',').map do |category_name|
    Category.find_or_create_by(name: category_name.strip)
  end

  Product.create(
    name: row['name'],
    description: row['description'],
    price: row['price'].to_f,
    stock_quantity: row['stock_quantity'].to_i,
    categories: categories
  )
end