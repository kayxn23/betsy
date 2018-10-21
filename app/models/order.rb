class Order < ApplicationRecord
  has_many :orders_items, dependent: :destroy
  has_many :products, through: :orders_items, dependent: :destroy 

  belongs_to :user, optional: true

  # {
  #   orders_item: {
  #     product_id: 1,
  #     quantity: 20
  #   }
  # }
  def add_product(product_params)
    current_product = OrdersItem.find_by(product_id: product_params[:orders_item][:product_id])

    if current_product
      current_product.quantity += product_params[:orders_item][:quantity].to_i
      current_product.save
    else
      current_product = OrdersItem.create(product_id: product_params[:orders_item][:product_id],
                                          quantity: product_params[:orders_item][:quantity],
                                          order_id: self.id)
    end

    return current_product
  end
end
