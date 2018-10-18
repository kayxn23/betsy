class Order < ApplicationRecord
  has_many :products, through: :orders_items
  belongs_to :user 
end
