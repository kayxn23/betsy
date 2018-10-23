class Product < ApplicationRecord
  has_and_belongs_to_many :categories # do we need dependent: :destroy here?
  belongs_to :user
  has_many :orders_items
  has_many :orders, through: :orders_items

  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  validates :stock, presence: true

end
