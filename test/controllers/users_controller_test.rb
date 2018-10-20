require "test_helper"

describe UsersController do
  it "should get new" do
    get users_new_url
    value(response).must_be :success?
  end

  describe "show" do
    it "should get show" do
      # Arrange
      id = users(:grace).id

      # Act
      get user_path(id)

      # Assert
      must_respond_with :success
    end

    it "should respond with not_found if given an invalid id" do
      # Arrange
      id = -1

      # Act
      get user_path(id)

      #Assert
      must_respond_with :not_found
      expect(flash[:danger]).must_equal "Cannot find the book -1"
    end
  end
  
  it "should get create" do
    get users_create_url
    value(response).must_be :success?
  end


end
