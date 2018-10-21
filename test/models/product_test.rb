require "test_helper"

describe Product do
  let(:product) { products(:graveyard) }

  it "must be valid" do
    expect(product).must_be :valid?
  end

  it "must have required fields" do
    fields = [:name, :price, :description, :photo, :stock]

    fields.each do |field|
      expect(product).must_respond_to field
    end
  end

  describe 'Relationships' do
    it 'belongs to user' do
      user = product.user

      expect(user).must_be_instance_of User
      expect(user.id).must_equal product.user_id
    end

    it 'can have many categories' do
      product.categories << Category.first
      categories = product.categories

      expect(categories.length).must_be :>=, 1
      categories.each do |category|
        expect(category).must_be_instance_of Category
      end

    end

    it 'can have many orders' do
    end
  end
  describe 'Validations' do
    it 'must have name' do
        product = products(:haunted_house)
        product.name = nil

        valid = product.save
        expect(valid).must_equal false
        expect(product.errors.messages).must_include :name

    end

    it 'must have price' do
      product = products(:haunted_house)
      product.price = nil

      valid = product.save
      expect(valid).must_equal false
      expect(product.errors.messages).must_include :price
    end

    it 'must have description' do
      product = products(:haunted_house)
      product.description = nil

      valid = product.save
      expect(valid).must_equal false
      expect(product.errors.messages).must_include :description
    end

    it 'must have photo' do
      product = products(:haunted_house)
      product.photo = nil

      valid = product.save
      expect(valid).must_equal false
      expect(product.errors.messages).must_include :photo
    end

    it 'must have stock' do
      product = products(:haunted_house)
      product.stock = nil

      valid = product.save
      expect(valid).must_equal false
      expect(product.errors.messages).must_include :stock
    end



  end
end
