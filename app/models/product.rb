class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :user
  has_many :orders, through: :orders_items
  #should this has_many relationship be:
  #belongs_to :orders, through: :order_items ??


end
