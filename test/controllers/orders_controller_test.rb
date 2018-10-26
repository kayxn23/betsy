require "test_helper"

describe OrdersController do

  describe " update" do
    let (:order_hash) do
      {
        order: {
          status: "pending", street: "123 sunny rd", city: "seattle", state: "WA", zip: 98112,
          creditcard: 1234, cvv: 234, billingzip: 98112, ccexpiration: Date.today
        }
      }
    end


    describe "update" do
      it "can update a order with valid params" do
      id = orders(:one).id
      binding.pry
      expect {
      patch order_path(id), params: order_hash
    }.wont_change 'Order.count'

      must_respond_with :redirect
      must_redirect_to order_path(id)

      new_order = Order.find_by(id: id)


      expect(new_order.status).must_equal order_hash[:order][:status]
      expect(new_order.street).must_equal order_hash[:order][:street]
      expect(new_order.city).must_equal order_hash[:order][:city]
      expect(new_order.state).must_equal order_hash[:order][:state]
      expect(new_order.zip).must_equal order_hash[:order][:zip]
      expect(new_order.creditcard).must_equal order_hash[:order][:creditcard]
      expect(new_order.cvv).must_equal order_hash[:order][:cvv]
      expect(new_order.billingzip).must_equal order_hash[:order][:billingzip]
    end

    it "gives an error if the order params are invalid" do
      # Arrange
      order = orders(:one)
      order.status = "invalid_status"

      expect {
          patch order_path(order.id), params: order_hash
        }.wont_change 'Order.count'
        binding.pry
        new_order = Order.find(order.id)

        must_respond_with :bad_request
        expect(new_order.status).must_equal new_order.status
        expect(new_order.street).must_equal  new_order.street
        expect(new_order.city).must_equal  new_order.city
        expect(new_order.state).must_equal  new_order.state
        expect(new_order.zip).must_equal  new_order.zip
        expect(new_order.creditcard).must_equal  new_order.creditcard
        expect(new_order.cvv).must_equal  new_order.cvv
        expect(new_order.billingzip).must_equal  new_order.billingzip
    end

      #
      # describe "update" do
      #   it "can update a order with valid params" do
      #     id = orders(:one).id
      #
      #     expect {
      #       patch order_path(id), params: order_hash
      #     }.wont_change 'Order.count'
      #
      #     must_respond_with :redirect
      #     must_redirect_to order_path(id)
      #
      #     new_order = Order.find_by(id: id)
      #
      #
      #     expect(new_order.status).must_equal order_hash[:order][:status]
      #     expect(new_order.street).must_equal order_hash[:order][:street]
      #     expect(new_order.city).must_equal order_hash[:order][:city]
      #     expect(new_order.state).must_equal order_hash[:order][:state]
      #     expect(new_order.zip).must_equal order_hash[:order][:zip]
      #     expect(new_order.creditcard).must_equal order_hash[:order][:creditcard]
      #     expect(new_order.cvv).must_equal order_hash[:order][:cvv]
      #     expect(new_order.billingzip).must_equal order_hash[:order][:billingzip]
      #   end
      #
      #   it "gives an error if the order params are invalid" do
      #     # Arrange
      #     order_hash[:order][:status] = "invalid_status"
      #     id = orders(:one).id
      #     old_order = orders(:one)
      #
      #     expect {
      #       patch order_path(id), params: order_hash
      #     }.wont_change 'Order.count'
      #     new_order = Order.find(id)
      #
      #     must_respond_with :bad_request
      #     expect(new_order.status).must_equal new_order.status
      #     expect(new_order.street).must_equal  new_order.street
      #     expect(new_order.city).must_equal  new_order.city
      #     expect(new_order.state).must_equal  new_order.state
      #     expect(new_order.zip).must_equal  new_order.zip
      #     expect(new_order.creditcard).must_equal  new_order.creditcard
      #     expect(new_order.cvv).must_equal  new_order.cvv
      #     expect(new_order.billingzip).must_equal  new_order.billingzip
      #   end
      #   it "gives not_found for a order that doesn't exist" do
      #     id = -1
      #
      #     expect {
      #       patch order_path(id), params: order_hash
      #     }.wont_change 'Order.count'
      #
      #     must_respond_with :not_found
      #
      #   end

    #kay uncomment the above
    #
    #     it "should get an order's show page" do
    #       #Arrange
    #       id = orders(:one).id
    #       #Act
    #       get order_path(id)
    #       #Assert
    #       must_respond_with :success
    #     end
    #
    #     it "should respond with not_found if given an invalid id" do
    #       #asrrange - invalid id
    #       id = -1
    #       #Act
    #       get order_path(id)
    #       #Assert
    #       must_respond_with :not_found
    #       expect(flash[:danger]).must_equal "Cannot find the order -1"
    #     end
    #
    # #
    # # describe "edit" do
    # #  it "can get the edit page for a valid order" do
    # #    # Arrange
    # #    id = orders(:one).id
    # #
    # #    # Act
    # #    get edit_order_path(id)
    # #
    # #    # Assert
    # #    must_respond_with :success
    # #  end
    # #  it "should respond with not_found if given an invalid id" do
    # #    # Arrange - invalid id
    # #    id = -1
    # #
    # #    # Act
    # #    get edit_order_path(id)
    # #
    # #    # Assert
    # #    expect(response).must_be :not_found?
    # #    must_respond_with :not_found
    # #    expect(flash[:danger]).must_equal "Cannot find the order -1"
    # #    end
    # #  end
    #
    #  describe "destroy" do
    #    it "can destroy a order given a valid id" do
    #      # Arrange
    #      id = orders(:one).id
    #
    #      # Act - Assert
    #      expect {
    #        delete order_path(id)
    #      }.must_change 'Order.count', -1
    #
    #      must_respond_with :redirect
    #      must_redirect_to orders_path(order.id)
    #      expect(Order.find_by(id: id)).must_equal nil
    #    end
    #
    #    it "should respond with not_found for an invalid id" do
    #      id = -1
    #
    #      expect {
    #        delete order_path(id)
    #        # }.must_change 'Book.count', 0
    #      }.wont_change 'Order.count'
    #
    #      must_respond_with :not_found
    #      expect(flash.now[:danger]).must_equal "Cannot find the order #{id}"
    # end
    # end

        # must_respond_with :not_found

      end
    end

      it "should get an order's show page" do
        #Arrange
        id = orders(:one).id
        #Act
        get order_path(id)
        #Assert
        must_respond_with :success
      end

      it "should respond with not_found if given an invalid id" do
        #asrrange - invalid id
        id = -1
        #Act
        get order_path(id)
        #Assert
        must_respond_with :not_found
        expect(flash[:danger]).must_equal "Cannot find the order -1"
      end

 end
