class CancelReservation
  def initialize(reservation)
    @reservation = reservation
  end

  def call
    check_reservation_status
    cancel_reservation
  end

  private

  def check_reservation_status
    unless @reservation.pending?
      raise(ExceptionHandler::InvalidRequest, Message.cannot_cancel_reservation)
    end
  end

  def cancel_reservation
    @reservation.canceled!
  rescue ActiveRecord::RecordInvalid
    raise(ExceptionHandler::InvalidRequest, Message.reservation_not_updated)
  end
end