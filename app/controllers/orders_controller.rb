class OrdersController < ApplicationController


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

  # def create
  #   #don't need create
  #
  #   @current_order = Order.new(order_params)
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

  def show
      @order = Order.find_by(id:session[:order_id])
  end

    def index
      @orders = Order.all
    end

    def edit
      #will display the form the user fills out with address ect..
      #this is the view
      #partial called edit.erb
      #get returns a result
    end

    def update
      #patch
      #this does not have an .erb
      #the form posts to the update method
      #will recieve a post from edit and it will toggle the order to complete
      #save order
      #get the order and update it
    end

    def destroy
    end

  private
  def order_params
    return params.require(:order).permit(:status, :street, :city, :state, :zip,
      :creditcard, :cvv, :billingzip, :ccexpiration, :user_id)
  end

end
