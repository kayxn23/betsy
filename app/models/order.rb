class Order < ApplicationRecord
  has_many :orders_items, dependent: :destroy
  has_many :products, through: :orders_items, dependent: :destroy

  belongs_to :user, optional: true

  #validation so that a user cannot have any products that have their user_id

  # validates :status, presence: true, inclusion: { in: %w(pending complete paid cancelled)}
  # validates :street, presence: true
  # validates :city, presence: true
  # validates :state, presence: true, inclusion: { in: %w(AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY)}
  # validates :zip, presence: true, length: {is: 5}, numericality: { only_integer: true }
  # validates :creditcard, presence: true, length: {is: 4},numericality: { only_integer: true }
  # validates :cvv, presence: true, length: {is: 3},numericality: { only_integer: true }
  # validates :billingzip, presence: true, length: {is: 5},numericality: { only_integer: true }


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
