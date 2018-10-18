class UsersController < ApplicationController
  def new

  end

  def create
  end

  def show
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash.now[:danger] = "Cannot find the user #{params[:id]}"
      render :notfound, status: :not_found
    end
  end

  def user_params
    raise 
    return params.require(:user).permit(:name, :email, :street, :city, :state, :zip, :creditcard, :ccexpiration, :cvv, :billingzip, :photo)
    raise
  end
end
