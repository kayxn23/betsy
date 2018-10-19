class ApplicationController < ActionController::Base
  before_action :find_merchant
  before_action :is_merchant?
  before_action :set_order
  private

  def find_merchant
    @merchant = User.find_by(id: session[:user_id], provider: 'github')
  end

  def is_merchant?
    return @merchant
  end

  def set_order
    #Does an order exist?
    @order = Order.find_by(id:session[:order_id])

    #There is no order in the db
    if @order.nil?
      if @merchant #Does the order have a merchant?
        @order = Order.create(user_id: @merchant.id, status: "pending")
        session[:order_id] = @order.id
      else #They are checking out as a guest, there won't be a user_id relation
        @order = Order.create(status: "pending")
        session[:order_id] = @order.id
      end
    end

  end



end
