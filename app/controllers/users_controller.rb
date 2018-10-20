class UsersController < ApplicationController
  # May need to add edit/update/destroy to this later
  before_action :find_user, only: [:show]
  # Do we want to require login for the
  # merchant show page/index page
  # Or does the view change based on if it's
  # a merchant looking at own products (can edit products/add products)
  # vs a shopper looking at a merchant's homepage (just show products, no edit/add)?
  # I think that logic would be attached to the product
  # show page
  before_action :require_login, only: [:show]
  def new
    @user = User.new
    # How is user linked to product?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # We run User.create on the checkout page
      # (Merchant creation is done via oauth login)
      flash[:success] = "Account saved!"
      redirect_to root_path, status: :success
    else
      # Could not save
      flash[:danger] = "Could not save account"
      # Render new user form again
      render :new, status: :bad_request
    end
  end

  #TODO Do we need update? Are we letting merchants edit/update?

# before action to find user already applied
# Will be redirected if not a merchant
  def show
  end

  private

  def find_user
    # Try to find the user
    @user = User.find_by(id: params[:id].to_i)
    # binding.pry
    # If user doesn't exist flash a message /render notfound page
    if @user.nil?
      flash.now[:danger] = "Cannot find the user #{params[:id]}"
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
