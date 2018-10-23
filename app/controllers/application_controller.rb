class ApplicationController < ActionController::Base
  before_action :current_order
  before_action :find_merchant
  before_action :is_merchant?
  before_action :find_user

  # def render_404
  #   # DPR: this will actually render a 404 page in production
  #   raise ActionController::RoutingError.new('Not Found')
  # end

  private

  def find_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    # Check if current user is logged in (has uid/provider)
    # Would have user_id and provider and uid
    # binding.pry
    if !find_merchant
      flash[:danger] = "You must be logged in to view this section"
      redirect_to root_path
    end
  end

  def find_merchant
    @merchant = User.find_by(id: session[:user_id], provider: 'github')
    # What if it's nil?
  end

  def is_merchant?
    # binding.pry
    return @merchant
  end

  def find_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_order
    # If nil, make one
    # Else, find and use the current one
    if session[:order_id].nil?
      @current_order = Order.create(status: "pending")
        session[:order_id] = @current_order.id
        return @current_order
    else
      @current_order = Order.find_by(id: session[:order_id])
      return @current_order
    end
  end

#   def current_order
#     @order = Order.find_by(id:session[:order_id])
#     return @order if @order
#     if is_merchant? #Does the order have a merchant?
#       @order = Order.find_by(user_id: @merchant.id, status: "pending")#to find pending orders for a merchant
#       session[:order_id] = @order.id
#     else #They are checking out as a guest, there won't be a user_id relation
#       @order = Order.create(status: "pending")
#       session[:order_id] = @order.id
#     end
# #call set order are a merchant, find pending = nil. never going to next else to create one
#     return @order
# #hint this method should have at least one case where we are seeing if session id is already set -
# #this will avoid assigning a new cart to somebody who has one
#   end
end
