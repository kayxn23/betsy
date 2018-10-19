require "test_helper"

describe SessionsController do
  describe "login" do
    it "Can log in an existing user" do
      # Arrange
      user = users(:grace)

      # Tell OmniAuth to use this user's info when it sees
      # an auth callback from github
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Act
      expect {
        get auth_callback_path('github')
      }.wont_change('User.count')

      # Assert
      must_redirect_to root_path
      expect(session[:user_id]).must_equal user.id
    end

    it "Can log in a new user with good data" do
      # Arrange
      user = users(:grace)
      user.destroy

      # Tell OmniAuth to use this user's info when it sees
      # an auth callback from github
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Act
      expect {
        get auth_callback_path('github')
      }.must_change('User.count', +1)

      # Assert
      must_redirect_to root_path
      expect(session[:user_id]).wont_be_nil
    end

    it "Rejects a user with invalid data" do
      # Arrange
      user = users(:grace)
      # Making use have invalid data
      user.name = nil

      # Tell OmniAuth to use this user's info when it sees
      # an auth callback from github
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Act - Will not change user count
        get auth_callback_path('github')

        # Assert
        # Won't add a user to database
        must_change('User.count', 0)
        # Will flash an error
        expect(flash[:error]).must_equal "Could not create new user account: #{user.errors.messages}"
        # And redirect to root_path
        must_respond_with :redirect
        must_redirect_to root_path

    end
  end
end
