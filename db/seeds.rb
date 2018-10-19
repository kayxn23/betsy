# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'


CATEGORY_FILE = Rails.root.join('db', 'category_seeds_3.csv')
puts "Loading raw category data from #{CATEGORY_FILE}"

category_failures = []
CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
  category = Category.new
  category.name = row['name']
  successful = category.save
  if !successful
    category_failures << category
    puts "Failed to save categories: #{category.inspect}"
  else
    puts "Created categories: #{category.inspect}"
  end
end

puts "Added #{Category.count} category records"
puts "#{category_failures.length} category failed to save"

#--------------------------------------------------------

USER_FILE = Rails.root.join('db', 'user_seeds_3.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.name = row['name']
  user.email = row['email']
  user.photo = row['photo']
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save users: #{user.inspect}"
  else
    puts "Created users: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} user failed to save"

#--------------------------------------------------------

ORDERS_FILE = Rails.root.join('db', 'order_seeds_3.csv')
puts "Loading raw order data from #{ORDERS_FILE}"

order_failures = []
CSV.foreach(ORDERS_FILE, :headers => true) do |row|
  order= Order.new
  order.status = row['status']
  order.street = row['street']
  order.city = row['city']
  order.state = row['state']
  order.zip = row['zip']
  order.creditcard = row['creditcard']
  order.ccexpiration = Date.parse(row['ccexpiration'])
  order.cvv = row['cvv']
  order.billingzip = row['billingzip']
  successful = order.save
  if !successful
    order_failures <<  order
    puts "Failed to save orders: #{order.inspect}"
  else
    puts "Created orders: #{order.inspect}"
  end
end

puts "Added #{Order.count} order records"
puts "#{order_failures.length}  order failed to save"

#--------------------------------------------------------

PRODUCTS_FILE = Rails.root.join('db', 'product_seeds_3.csv')
puts "Loading raw product data from #{PRODUCTS_FILE}"

product_failures = []
CSV.foreach(PRODUCTS_FILE, :headers => true) do |row|
  product = Product.new
  product.name = row['name']
  product.price = row['price']
  product.description = row['description']
  product.photo = row['photo']
  product.stock = row['stock']
  product.user_id = row['user_id']
  successful = product.save
  if !successful
    product_failures << product
    puts "Failed to save products: #{product.inspect}"
  else
    puts "Created products: #{product.inspect}"
  end
end

puts "Added #{Product.count} product records"
puts "#{product_failures.length} product failed to save"
