module ExceptionHandler
  extend ActiveSupport::Concern
  include Response  # Response concern 포함

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ExceptionHandler::AuthenticationError do |e|
      error_response(e.message, :unauthorized)
    end

    rescue_from ExceptionHandler::MissingToken do |e|
      error_response(e.message, :unprocessable_entity)
    end

    rescue_from ExceptionHandler::InvalidToken do |e|
      error_response(e.message, :unprocessable_entity)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      error_response(e.message, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error_response(e.message, :unprocessable_entity, e.record.errors.messages)
    end
  end
end