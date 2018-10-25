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

  # def create
  #   @order = Order.new(order_params)
  #    if @order.save # save returns true if the database insert succeeds
  #      flash[:success] = 'Order Created!'
  #
  #      redirect_to root_path # go to the index so we can see the book in the list
  #    else # save failed :(
  #      flash.now[:danger] = 'Order not created!'
  #
  #      render :new, status: :bad_request # show the new book form view again
  #    end
  #  end

  def edit
  end

  def update
    if @order && @order.update(order_params)
      flash[:status] = :success
      flash[:result_text] = "Success! Order #{@order.id} is complete! Enjoy your unique home!"
      redirect_to order_path(@order.id) #Redirect to order confirmation
    else
      flash.now[:status] = :failure
      flash.now[:result_text] = "Could not update #{@order.id}. Please check the forms"
      flash.now[:messages] = @order.errors.messages
      render :edit, status: :bad_request
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

  def find_order
    @order = Order.find_by(id: params[:id].to_i)

    if @order.nil?
      flash.now[:danger] = "Cannot find the order #{params[:id]}"
      render :notfound
    end
  end

end
