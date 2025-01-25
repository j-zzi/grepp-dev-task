module Response
  def json_response(data, status, message)
    render json: {
      status: Rack::Utils.status_code(status),
      data: data,
      message: message
    }, status: status
  end

  def error_response(message, status, errors = nil)
    response = {
      status: Rack::Utils.status_code(status),
      error: {
        message: message,
        code: status.to_s
      }
    }
    response[:error][:details] = errors if errors.present?
    
    render json: response, status: status
  end
end