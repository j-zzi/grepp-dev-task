module Response
  def json_response(data = nil, status = :ok, message = nil)
    status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
    render json: {
      status: status_code,
      message: message,
      data: data
    }, status: status
  end
end