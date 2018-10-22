class OrdersItemsController < ApplicationController
before_action :set_order

#add hidden field to products index each do captures price and quantity

  def new
      @orders_items = OrdersItem.new
    end

  def create
    @orders_items = OrdersItem.new.add_product(params )  #add orders_items

    #Product id and quantity
    #
    # redirect_to orders_path
  if @order.save
    redirect_to orders_path
    else
      flash[:error] = 'There was a problem addding this to your cart'
      redirect_to root_path #update to fallback to last page or product show
    end
  end

  def destroy
    @orders_item.destroy
    redirect_to order_path
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
    end

    def order_item_params
      params.require(:order_item).permit(:product_id, :order_id, :quantity, :price)
    end

end
