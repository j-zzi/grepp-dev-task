class UserController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # POST /signup
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    json_response(auth_token,:created, Message.account_created)
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
    )
  end
end
