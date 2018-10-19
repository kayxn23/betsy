class CategoriesController < ApplicationController
  def new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "#{@category.name} added!"
      redirect_to user_path
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
