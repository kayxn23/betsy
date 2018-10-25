class OrdersItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  
  def calculate_total
    return self.product.price * self.quantity
  end
end
