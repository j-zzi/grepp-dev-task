class UpdateReservation
  def initialize(reservation, update_params)
    @reservation = reservation
    @update_params = update_params
  end

  def call
    check_reservation_status
    update_reservation
  end

  private

  def check_reservation_status
    unless @reservation.pending?
      raise(ExceptionHandler::InvalidRequest, Message.not_pending_reservation)
    end
  end

  def update_reservation
    @reservation.update!(@update_params)
  rescue ActiveRecord::RecordInvalid => e
    raise(ExceptionHandler::InvalidRequest, Message.reservation_not_updated)
  end
end