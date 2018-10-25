class OrdersController < ApplicationController
    #before_action :find_order, only: [:edit,:update]

  #
  # def new #WRONG TO HAVE @ORDER
  #   #doesn't exist on the website
  #   #new is created by before action
  #   @order = Order.new
  #   # Find user
  #   # If no user, User.create
  #  if params[:user_id]
  #    @user_id = params[:user_id].to_i
  #    user = User.find_by(id: @user_id)
  #    if user.nil?
  #      flash.now[:warning] = "That user doesn't exit"
  #    end
  #    @order.user_id = @user_id
  #  end
  # end
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


  def edit
    #will display the form the user fills out with address ect..
    #this is the view
    #partial called edit.erb
    #get returns a result
  end

  def update
    if @current_order && @current_order.update(order_params)

      flash[:status] = :success
      flash[:result_text] = "Success! Order #{@current_order.id} is complete! Enjoy your unique home!"
      redirect_to order_path(@current_order.id) #Redirect to order confirmation
    else
      flash.now[:status] = :failure
      flash.now[:result_text] = "Could not update #{@current_order.id}. Please check the forms"
      flash.now[:messages] = @current_order.errors.messages
      render :edit, status: :bad_request
      #patch
      #this does not have an .erb
      #the form posts to the update method
      #will recieve a post from edit and it will toggle the order to complete
      #save order
      #get the order and update it
    end
  end

  def show
      @order = Order.find_by(id:session[:order_id])
  end

    def index
      @orders = Order.all
    end

    def destroy
    end

  private
  def order_params
    return params.require(:order).permit(:status, :street, :city, :state, :zip, :creditcard, :cvv, :billingzip, :ccexpiration, :user_id)
  end

  def find_order
    @order = Order.find_by(id: params[:id].to_i)

    if @order.nil?
      flash.now[:danger] = "Cannot find the order #{params[:id]}"
      render :notfound
    end
  end

end
