class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :retire]
  before_action :require_login, except: [:index, :show, :add_to_cart]

  # before_action :login, except: [:edit, :new] do we want to add this?

  def index
    #pretty sure want to add an if statement to show by category's id but not sure if its connect in the schema correctly
    @products = Product.all.order(:name)
  end
  #@task.update(
  #name: params[:task][:name],
  #description: params[:task][:description],
  #completion_date: params[:task][:completion_date])

  def show; end

  def add_to_cart
    product = Product.find_by(id: params[:id])
    order = Order.find_by(id: session[:order_id])
    @orders_item = OrdersItem.new(product_id: product.id, order_id: order.id, quantity: 1)
    redirect_to root_path
  end

  def new
    @product = Product
    # There should be a merchant to create a new product
    # @merchant should be available via application controller
    if @merchant
      @product.user_id = @merchant.id
    else
      flash.now[:warning] = "That merchant does not exist"
    end
  end

  def edit; end

  def retire
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = 'Product Created!'

      redirect_to product_path(@product.id)
    else
      flash.now[:danger] = 'Product not created!'

      render :new, status: :bad_request
    end
  end

  def update
    if @product && @product.update(product_params)
      redirect_to product_path(@product.id)
    elsif @product && !@product.valid? #the product exists and it was invalid inputs
      render :edit, status: :bad_request
    end
  end

  def destroy
    unless @product.nil?
      @product.destroy
      flash[:success] = "#{@product.name} deleted"
      redirect_to root_path
    end
  end

  private

  def find_product
    @product = Product.find_by(id: params[:id].to_i)
    # render_404 unless @product

    if @product.nil?
      flash.now[:danger] = "Cannot find the product #{params[:id]}"
      render :notfound, status: :not_found
    end
  end

  def product_params
    #can i access :category_id? not unless there isa belongs_to
    return params.require(:product).permit(:user_id, :name, :price, :description, :photo, :stock)
  end

end
