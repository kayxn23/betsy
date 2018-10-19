require "test_helper"

describe Order do
  it "must be valid" do
    order = Order.new
    order.valid?.must_equal true
  end

  describe "add_product" do
    let(:order) { orders(:one) }

    it "adds product to order" do
      product = products(:graveyard)

      product_params = {
        orders_item: {
          product_id: product.id,
          quantity: 5
        }
      }

      expect(order.products.count).must_equal 0
      order.add_product(product_params)
      expect(order.products.count).must_equal 1
      expect(order.products.first.id).must_equal product.id
    end

    it "increases the quantity of a product if it exists" do
    end

    it "will not add item if product is nil" do
    end
  end
end
