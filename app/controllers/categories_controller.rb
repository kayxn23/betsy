class CategoriesController < ApplicationController

  def index
    @categories = Category.all.order(:name)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "#{@category.name} added!"
      redirect_to user_path
<<<<<<< HEAD
    end
  end
=======
>>>>>>> c78746b7bf79ecb9665f55a8d22fa0122ecbe8aa

      redirect_to root_path #change this to dashboard_path
    else #save failed
      flash.now[:danger] = "Category #{@category.name} not added!"

      render :new, status: :bad_request
    end
  end

  def show
    @category = Category.find_by(id: params[:id])

    if @cateogry.nil?
      flash.now[:danger] = "Cannot find the category #{params[:id]}"
      render :notfound, status: :not_found
    end
  end

  private

  def category_params
    return params.require(:category).permit(:name)
  end


end
