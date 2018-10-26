require "test_helper"
require 'pry'
describe Order do
  let(:order) { orders(:one) }
  it "must be valid" do
    order = Order.new
    order.status = "pending"
    order.valid?.must_equal true
  end

  it "must have required fields" do
    fields = [ :status,:street,:city,:state,:zip,:creditcard,:cvv,:billingzip, :name, :email]

    fields.each do |field|
      expect(order).must_respond_to field
    end
  end

  describe 'Relationships' do
    it 'can belong to user' do
      users(:user1)

      user = order.user

      expect(user).must_be_instance_of User
      expect(user.id).must_equal order.user_id
    end


    it 'can have many products' do
      order.products << products(:product1)
      products = order.products

      expect(products.length).must_be :>=, 1
      products.each do |product|
        expect(product).must_be_instance_of Product
      end
    end
  end

  describe 'Validations' do
    #Need to add tests here
    #Validation that a product could not be added
    #
  end

  describe "add_product" do
    let(:order) { orders(:one) }

    it "adds product to order" do
      product = products(:product1)

      product_params = {
        orders_item: {
          product_id: product.id,
          quantity: 5
        }
      }

      num_p = order.products.count
      order.add_product(product_params,1)
      binding.pry
      expect(order.products.count).must_equal num_p + 1
      expect(order.products.first.id).must_equal product.id
    end

    it "increases the quantity of a product if it exists" do
    end

    it "will not add item if product is nil" do
    end
  end
end
