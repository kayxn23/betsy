require "test_helper"
require 'pry'
describe OrdersItem do
 let(:item) { orders_items(:item1) }
 it "must be valid" do
   item.valid?.must_equal true
 end

 it "must have required fields" do
   fields = [ :order_id, :product_id, :quantity]

   fields.each do |field|
     expect(item).must_respond_to field
   end
 end

 describe 'Relationships' do
   it 'belongs to order' do
     order = item.order

     expect(order).must_be_instance_of Order
     expect(order.id).must_equal item.order_id
   end
 end
end
