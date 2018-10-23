require "test_helper"

describe OrdersItem do
 let(:item) { ordersitems(:item1) }
 it "must be valid" do
   orderitem = OrdersItem.new
   orderitem.valid?.must_equal true
 end

 it "must have required fields" do
   fields = [ :order_id, :product_id, :quantity]

   fields.each do |field|
     expect(item).must_respond_to field
   end
 end

 describe 'Relationships' do
   it 'belongs to user' do
     user = order.user

     expect(user).must_be_instance_of User
     expect(user.id).must_equal order.user_id
   end
 end
end
