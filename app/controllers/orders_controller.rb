class OrdersController < ApplicationController



  def new
    @order = Order.new
    # Find user
    # If no user, User.create
   if params[:user_id]
     @user_id = params[:user_id].to_i
     user = User.find_by(id: @user_id)
     if user.nil?
       flash.now[:warning] = "That user doesn't exit"
     end
     @order.user_id = @user_id
   end
  end

  def create
    @order = Order.new(order_params)
     if @order.save # save returns true if the database insert succeeds
       flash[:success] = 'Order Created!'

       redirect_to root_path # go to the index so we can see the book in the list
     else # save failed :(
       flash.now[:danger] = 'Order not created!'

       render :new, status: :bad_request # show the new book form view again
     end
   end

  def show
      @order = Order.find_by(id:session[:order_id])
  end

    def index
      @orders = Order.all
    end

  private
  def order_params
    return params.require(:order).permit(:status)
  end

end
