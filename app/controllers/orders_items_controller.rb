class OrdersItemsController < ApplicationController
before_action :current_order

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
    params[:product][:category_ids] ||= [] #if category_ids returns nil it will be set to empty array
    if @product && @product.update(product_params)
      redirect_to product_path(@product.id)
    elsif @product && !@product.valid? #the product exists and it was invalid inputs
      render :edit, status: :bad_request
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
      @orders_item = OrderItems.find(params[:id])
      if @orders_item.nil?
        flash.now[:danger] = "Cannot find the item #{params[:id]} in the cart"
        render :notfound
      end
    end

    def order_item_params
      params.require(:order_item).permit(:product_id, :order_id, :quantity)
    end

end
