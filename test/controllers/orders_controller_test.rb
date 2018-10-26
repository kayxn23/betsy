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
      order = orders(:one)
      expect {
      patch order_path(order.id), params: order_hash
    }.must_change 'Order.count', 1

      must_respond_with :redirect
      # binding.pry
      must_redirect_to confirmation_path(@current_order.id)


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
      order_hash[:order][:status] = "invalid_status"

      expect {
          patch order_path(order.id), params: order_hash
        }.wont_change 'Order.count'
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
    #
    # #
    describe "edit" do
     it "can get the edit page for a valid order" do
       # Arrange
       id = orders(:one).id

       # Act
       get edit_order_path(id)

       # Assert
       must_respond_with :success
     end

     it "should respond with not_found if given an invalid id" do
       # Arrange - invalid id
       id = -1
       # Act
       get edit_order_path(id)

       # Assert
       expect(response).must_be :not_found?
       must_respond_with :not_found
       expect(flash[:danger]).must_equal "Cannot find the order -1"
       end
     end

      end
    end

    describe "show" do

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


 end
