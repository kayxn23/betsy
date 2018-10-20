class Category < ApplicationRecord
  has_and_belongs_to_many :products # do we need dependent: :destroy here?  
end
