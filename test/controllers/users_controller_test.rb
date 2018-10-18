require "test_helper"

describe UsersController do
  it "should get new" do
    get users_new_url
    value(response).must_be :success?
  end

  it "should get create" do
    get users_create_url
    value(response).must_be :success?
  end

  it "should get show" do
    get users_show_url
    value(response).must_be :success?
  end

end
