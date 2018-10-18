class User < ApplicationRecord
  has_many :orders
  has_many :products

  def self.build_from_github(auth_hash)
   new_user = User.new

   new_user.uid = auth_hash[:uid]
   new_user.provider = 'github'
   new_user.name = auth_hash[:info][:name]
   new_user.email = auth_hash[:info][:email]

   return new_user
  end
end
