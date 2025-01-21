class ApplicationController < ActionController::API
  before_action :authorize_request

  private

  def authorize_request
    authorization = AuthorizeApiRequest.new(request.headers)
    @current_user = authorization.call[:user]
  rescue ExceptionHandler::InvalidToken => e
    render json: { error: e.message }, status: :unauthorized
  rescue ExceptionHandler::MissingToken => e
    render json: { error: e.message }, status: :unauthorized
  end
end
