class ApplicationController < ActionController::Base
  before_action :set_order
  before_action :find_merchant
  before_action :is_merchant?


  # def render_404
  #   # DPR: this will actually render a 404 page in production
  #   raise ActionController::RoutingError.new('Not Found')
  # end


  private

  def find_merchant
    @merchant = User.find_by(id: session[:user_id], provider: 'github')
  end

  def is_merchant?
    return @merchant
  end

  def set_order
    if is_merchant? #Does the order have a merchant?
      @order = Order.find_by(user_id: @merchant.id)
      session[:order_id] = @order.id
    else #They are checking out as a guest, there won't be a user_id relation
      @order = Order.create(status: "pending")
      session[:order_id] = @order.id
    end
    return @order
  end



end
