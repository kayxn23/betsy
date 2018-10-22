require "test_helper"

describe User do
  let(:user) { users(:dani) }

  it "must be valid" do
    expect(user).must_be :valid?
  end

  it "must have required fields" do
    fields = [:name, :email, :photo, :uid, :provider]

    fields.each do |field|
      expect(user).must_respond_to field
    end
  end

  describe 'Relationships' do

    it 'can have many products' do
      user.products << Product.first
      products = user.products

      expect(products.length).must_be :>=, 1
      products.each do |product|
        expect(product).must_be_instance_of Product
      end

    end

    it 'can have many orders' do
      user.orders << Order.first
      orders = user.orders

      expect(orders.length).must_be :>=, 1
      orders.each do |order|
        expect(order).must_be_instance_of Order
      end
    end
  end
  describe 'Validations' do
    it 'must have name' do
        user = users(:dani)
        user.name = nil

        valid = user.save
        expect(valid).must_equal false
        expect(user.errors.messages).must_include :name

    end

    it 'must have valid email' do
      invalid_emails = [nil , "@", "dan"]

      user = users(:dani)

      invalid_emails.each do |invalid_email|
        user.email = invalid_email

        valid = user.save
        expect(valid).must_equal false
        expect(user.errors.messages).must_include :email
      end
    end
  end
end
