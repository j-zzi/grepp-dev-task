class AdminController < ApplicationController
  before_action :authorize_admin

  private

  def authorize_admin
    unless current_user.admin?
      raise ExceptionHandler::InvalidRequest, Message.unauthorized
    end
  end
end
