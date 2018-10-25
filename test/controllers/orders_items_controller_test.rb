require "test_helper"

describe OrdersItemsController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
end

  it "can add new items to an order" do
    # "order_id" = $1  [["order_id", 193]]
    # => [#<OrdersItem:0x007fe709baef58 id: 15, order_id: 193, product_id: 3, quantity: 1>,
    #  #<OrdersItem:0x007fe709baed00 id: 16, order_id: 193, product_id: 3, quantity: 8>]
    # [5] pry(main)> Order.find_by(id:193).orders_items
  end

  it "can remove new items to an order" do
  end
