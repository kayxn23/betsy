# require "test_helper"
# require 'pry'
#
# describe OrdersController do
#   # Test new, create, and show
#   it "should get new" do
#     get orders_new_url
#     value(response).must_be :success?
#   end
#
#   it "should get create" do
#     order_hash = {
#       order: {
#         status: "pending"
#       }
#     }
#     # binding.pry
#     expect {
#       post orders_path, params: order_hash
#     }.must_change 'Order.count', 1
#
#     must_respond_with :redirect
#
#     expect(Order.last.status).must_equal order_hash[:order][:status]
#   end
#
#   it "should get show" do
#     get orders_show_url
#     value(response).must_be :success?
#   end
#
# end
