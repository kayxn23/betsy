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
    @user = user.new(user_params)
    if @user.save
      flash[:success] = "Merchant created!"
      # Send to merchant's home page
      redirect_to users_path(@user.id)
    else
      # Could not save
      flash[:danger] = "Could not create a new merchant."
      # Render new user form again
      render :new, status: :bad_request
    end
  end

  #TODO Do we need update? Are we letting merchants edit/update?

# before action to find user already applied
  def show
  end

  private

  def find_user
    # Try to find the user
    @user = User.find_by(id: params[:id])

    # If user doesn't exist flash a message /render notfound page
    if @user.nil?
      flash.now[:danger] = "Cannot find the user #{params[:id]}"
      redirect_to root_path
    end
  end

  def user_params
    # Do we need to add uid/provider to this?
    # I think those are optional as guest users are saved upon checkout
    return params.require(:user).permit(:name, :email, :photo)
  end
end
