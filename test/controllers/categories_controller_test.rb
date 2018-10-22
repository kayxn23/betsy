require "test_helper"

describe CategoriesController do
  it "should get index" do
    get categories_path
    must_respond_with :success
  end

  describe "new" do
    it "can get the new category page" do
      get new_category_path

      must_respond_with :success
    end
  end

  describe "create " do
    let (:category_hash) do
      {
        category: {
          name: 'Werewolf'
        }
      }
    end


    it "can create a new category given valid params" do
      #blocking this out for now until i have Cassy's dashboard view

      # Act-Assert
      expect {
        post categories_path, params: category_hash
      }.must_change 'Category.count', 1

      must_respond_with :redirect
      must_redirect_to root_path #do i need to change this to dashboard_path and add user id here?

      expect(Category.last.name).must_equal category_hash[:category][:name]

    end

    it "responds with an error for invalid params" do
      category_hash[:category][:name] = nil

      expect {
        post categories_path, params: category_hash
      }.wont_change 'Category.count'

      must_respond_with :bad_request
    end

  end #end of create describe block

  describe "show" do
    it "should get a category's show page" do
      id = categories(:category1).id

      get category_path(id)

      must_respond_with :success
    end
  end

end #end of categoriescontroller do


# def show
#   @category = Category.find_by(id: params[:id])
#
#   if @cateogry.nil?
#     flash.now[:danger] = "Cannot find the category #{params[:id]}"
#     render :notfound, status: :not_found
#   end
# end
