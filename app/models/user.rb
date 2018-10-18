class User < ApplicationRecord
  has_many :orders
  has_many :products

  def new_user
  end
end
