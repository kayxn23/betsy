class Order < ApplicationRecord
  has_many :orders_items
  has_many :products, through: :orders_items

  belongs_to :user, optional: true

  # {
  #   orders_item: {
  #     product_id: 1,
  #     quantity: 20
  #   }
  # }
  def add_product(product_params)
    #Find out if the current product is in the cart
    current_product = OrdersItem.find_by(product_id: product_params[:orders_item][:product_id])

    #If current_product is in the cart then
    if current_product
      #the current_product is an instance of OrdersItem which has quantity attribute
      current_product.quantity += product_params[:orders_item][:quantity].to_i
      current_product.save
    else
      #create a new instance of OrderItems with product params
      current_product = OrdersItem.create(product_id: product_params[:orders_item][:product_id],
                                          quantity: product_params[:orders_item][:quantity],
                                          order_id: self.id)
    end

    return current_product
  end
end
