class UsersController < ApplicationController
  # May need to add edit/update/destroy to this later
  before_action :find_user, only: [:show, :dashboard]
  before_action :require_login, only: [:dashboard]

# Might not need this as login does new oauth
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # We run User.create on the checkout page
      # (Merchant creation is done via oauth login)
      flash[:success] = "Account saved!"
      redirect_to root_path
    else
      # Could not save
      flash[:danger] = "Could not save account"
      # Render new user form again
      render :new, status: :bad_request
    end
  end

  #TODO Do we need update? Are we letting merchants edit/update?

# Is a page that shows all merchant's products
# If person is merchant of that id, can edit products
  def show
  end

#T TODO Need page showing all the merchants
# Write tests
  def index
    @merchants = User.where(uid: true )
  end

  # TODO write method to pull all products for a merchant
  def products
    # Find merchant id
    # Find products linked to that merchant
    # Show them
    id = params[:user_id].to_i
    @merchant = User.find_by(id: id)
    @products = @merchant.products.all
    if @merchant.nil?
      render :notfound, status: :not_found
    end
  end

  # Requires login to see merchant dashboard
  # Will show products, able to add product, edit product, see orders, etc.
  def dashboard

    # @user = find_user
    #Check if current user is the person for the dashboard view page
    #
    # if session[:user_id] != params[:id]
    #   flash[:warning] = "You can only view your own dashboard"
    #   redirect_to root_path, status: :bad_request
    # else
      @merchant = find_merchant
      @products = @merchant.products
    # end
    #
    # # How do we find order items for merchant? merchant.orderitems?
    # orderitems.where(merchant_id == @merchant.id) ?
    # @order_items_for_merchant = @merchant.orders_items

  end

  private

# Do I need this or can I just use the find_merchant method?
  def find_user
    # Try to find the user
    @user = User.find_by(id: params[:id].to_i)
    # binding.pry
    # If user doesn't exist flash a message /render notfound page
    if @user.nil?
      flash.now[:danger] = "Cannot find user"
      # binding.pry
      render :notfound , status: :not_found
    end
  end

  def user_params
    # Do we need to add uid/provider to this?
    # I think those are optional as guest users are saved upon checkout
    return params.require(:user).permit(:name, :email)
  end
end
