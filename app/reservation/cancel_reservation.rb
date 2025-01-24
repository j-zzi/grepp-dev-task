class CancelReservation
  def initialize(reservation)
    @reservation = reservation
  end

  def call
    check_reservation_status
    cancel_reservation
  end

  private

  attr_reader :reservation

  def check_reservation_status
    unless reservation.pending? || reservation.confirmed?
      raise(ExceptionHandler::InvalidRequest, Message.cannot_cancel_reservation)
    end
  end

  def cancel_reservation
    if reservation.update(status: :canceled)
      true
    else
      raise(ExceptionHandler::InvalidRequest, reservation.errors.full_messages.join(', '))
    end
  end
end