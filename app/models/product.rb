class Product < ApplicationRecord
  has_and_belongs_to_many :categories # do we need dependent: :destroy here? 
  belongs_to :user
  has_many :orders, through: :orders_items # do we need dependent: :destroy here?


end
