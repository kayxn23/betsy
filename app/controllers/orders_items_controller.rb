class OrdersItemsController < ApplicationController
before_action :set_order, only : [:create, :destroy]

#add hidden field to products index each do captures price and quantity
def create
  set_order.add_product(product_id: params[:product_id], #input was: (product_params)
quantity:params[:quantity]
)

redirect_to order_path
  # if @order.save
  #   redirect_to order_path
  # else
  #   flash[:error] = 'There was a problem addding this to your cart'
  #   redirect_to root_path #update to fallback to last page or product show
end
end
