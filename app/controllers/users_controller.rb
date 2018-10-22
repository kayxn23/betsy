class UsersController < ApplicationController
  # May need to add edit/update/destroy to this later
  before_action :find_user, only: [:show, :dashboard]
  before_action :require_login, only: [:dashboard]
  # Do we want to require login for the
  # merchant show page/index page
  # Or does the view change based on if it's
  # a merchant looking at own products (can edit products/add products)
  # vs a shopper looking at a merchant's homepage (just show products, no edit/add)?
  # I think that logic would be attached to the product
  # show page
  def new
    @user = User.new
    # How is user linked to product? Via ordersitems I think
  end

  def index
    @merchants = User.all.select { |user| user.uid }
  end


  def products
    # Show products for the merchant
    @merchant = User.find_by(id: params[:user_id])
    
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
# # If person is merchant of that id, can edit products
# Instead of show i'm setting up a product page per merchant
#   def show
#   end

  # Requires login to see merchant dashboard
  # Will show products, able to add product, edit product, see orders, etc.
  def dashboard
    @products = @merchant.products
    # How do we find order items for merchant? merchant.orderitems?

  end

  private

# Do I need this or can I just use the find_merchant method?
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

    return params.require(:user).permit(:name, :email, :photo, :uid, :provider)
  end
end
