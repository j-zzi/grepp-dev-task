class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token, :ok, Message.login_success)
  end

  private

  def auth_params
    params[:authentication].permit(:email, :password)
  end
end