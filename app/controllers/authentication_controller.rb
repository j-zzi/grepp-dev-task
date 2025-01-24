class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  # return auth token once user is authenticated
  def authenticate
    permitted_params = auth_params
    auth_token =
      AuthenticateUser.new(permitted_params[:email], permitted_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params[:authentication].permit(:email, :password)
  end
end