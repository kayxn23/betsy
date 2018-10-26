class OrdersItemsController < ApplicationController
before_action :current_order
before_action :set_order_item
#add hidden field to products index each do captures price and quantity

  def new
      # @orders_items = OrdersItem.new
    end

  def create
  #   @orders_items = OrdersItem.new.add_product(params )  #add orders_items
  #
  #   #Product id and quantity
  #   #
  #   # redirect_to orders_path
  # if @order.save
  #   redirect_to orders_path
  #   else
  #     flash[:error] = 'There was a problem addding this to your cart'
  #     redirect_to root_path #update to fallback to last page or product show
  #   end
  end

  def update
    # find order item by params id

    if order_item_params[:quantity].to_i == 0
      @orders_item.destroy
      flash.now[:danger] = "Removed item from your cart"
      redirect_to order_path(@current_order.id)
    else
     if @orders_item && @orders_item.update(order_item_params)
       flash[:success] = "The cart item #{@orders_item.product.name} has been updated"
       redirect_to order_path(@current_order.id)
     elsif @orders_item && !@orders_item.valid? #the order item exists and it was invalid input for quantity
       flash.now[:danger] = "Could not save the quantity to the cart"
       redirect_to order_path(@current_order.id)
     else
       flash[:danger] = "Something went wrong"
       redirect_to order_path(@current_order.id)
     end
   end
 end

  def destroy

    @orders_item = @current_order.orders_items.find(params[:id])
    @orders_item.destroy
    @current_order.save
    redirect_to order_path(@current_order)
  end


  # def add_to_cart
  #   product = Product.find_by(id: params[:id])
  #    order = Order.find_by(id: session[:order_id]))
  #    @orders_item = OrderItems.new(product_id: product.id, order_id: order.id, quantity: 1)
  #    redirect_to root_path
  # end

    def index
    end

    private

    def set_order_item
      @orders_item = OrdersItem.find(params[:id])
      if @orders_item.nil?
        flash.now[:danger] = "Cannot find the item #{params[:id]} in the cart"
        render :notfound
      end
    end

    def order_item_params
      params.permit( :quantity)
    end

end
