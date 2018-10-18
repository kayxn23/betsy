class ApplicationController < ActionController::Base
  before_action :is_merchant?

  private

  # def find_user
  #   @current_user = User.find_by(id: session[:user_id])
  # end
  #
  def is_merchant?
    return User.find_by(id: session[:user_id], provider: 'github')
  end


end
