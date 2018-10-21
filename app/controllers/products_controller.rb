class ProductsController < ApplicationController
  def index
    if
    end
  end

  def show
  end

  def update
  end

  def new
  end

  def create
  end

  def edit
  end

  def retire
  end

  # def destroy
  # end
  private

  def find_product
    @product = Product.find_by(id: params[:id].to_i)

    if @product.nil?
      flash.now[:danger] = "Cannot find the product #{params[:name]}"
      render :notfound, status: :not_found
    end
  end

  def product_params
    return params.require(:product).permit(:user_id, :name, :price, :description, :photo, :stock)
  end

end
