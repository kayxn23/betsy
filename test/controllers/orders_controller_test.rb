require "test_helper"
require 'pry'

describe OrdersController do
  # Test new, create, and show
  it "should get new" do
    get new_order_path
    value(response).must_be :success?
  end


  describe "create and update" do
    let (:order_hash) do
      {
        order: {
          status: "pending", street: "123 sunny rd", city: "seattle", state: "WA", zip: 98112,
          creditcard: 1234, cvv: 234, billingzip: 98112
        }
      }

    end

    describe "create" do
      it "can create a new order given valid params" do
        expect {
          post orders_path, params:order_hash
        }.must_change 'Order.count', 1
        must_respond_with :redirect
        must_redirect_to order_path(Order.last.id)

        expect(Order.last.status).must_equal order_hash[:order][:status]
      end

      it "responds with an error for invalid params" do
        # Arranges
        order_hash[:order][:status] = nil

        # Act-Assert
        expect {
          post order_path, params: order_hash
        }.wont_change 'Order.count'

        must_respond_with :bad_request

      end
    end

    describe "update" do
      it "can update a order with valid params" do
      id = orders(:one).id

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

    it "gives an error if the book params are invalid" do
      # Arrange
      order_hash[:order][:status] = "invalid_status"
      id = orders(:one).id
      old_order = orders(:one)

      expect {
          patch order_path(id), params: order_hash
        }.wont_change 'Order.count'
        new_order = Order.find(id)

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
        it "gives not_found for a order that doesn't exist" do
        id = -1

        expect {
          patch order_path(id), params: order_hash
        }.wont_change 'Order.count'

        must_respond_with :not_found

      end


      it "should get an order's show page" do
        #Arrange
        id = orders(:one).id
        #Act
        get order_path(id)
        #Assert
        must_respond_with: success
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

   describe "destroy" do
     it "can destroy a order given a valid id" do
       # Arrange
       id = orders(:one).id
       city = orders(:one).city

       # Act - Assert
       expect {
         delete book_path(id)
       }.must_change 'Book.count', -1

       must_respond_with :redirect
       must_redirect_to books_path
       expect(flash[:success]).must_equal "#{title} deleted"
       expect(Book.find_by(id: id)).must_equal nil
     end

     it "should respond with not_found for an invalid id" do
       id = -1

       # Equivalent
       # before_count = Book.count
       # delete book_path(id)
       # after_count = Book.count
       # expect(before_count).must_equal after_count

       expect {
         delete book_path(id)
         # }.must_change 'Book.count', 0
       }.wont_change 'Book.count'

       must_respond_with :not_found
       expect(flash.now[:danger]).must_equal "Cannot find the book #{id}"
     end
   end




end
