class Product < ApplicationRecord
  has_and_belongs_to_many :categories # do we need dependent: :destroy here?
  belongs_to :user
  has_many :orders, through: :orders_items
  #should this has_many relationship be:
  #belongs_to :orders, through: :order_items ??
  validates :name, uniqueness: true
  validates :name, presence: true




end
