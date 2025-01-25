class UpdateReservation
  def initialize(reservation, participants)
    @reservation = reservation
    @participants = participants
  end

  def call
    check_reservation_status
    update_reservation
  end

  private

  attr_reader :reservation, :participants

  def check_reservation_status
    unless reservation.pending?
      raise(ExceptionHandler::InvalidRequest, Message.cannot_update_reservation)
    end
  end

  def update_reservation
    reservation.update!(participants: participants)
  rescue ActiveRecord::RecordInvalid => e
    raise(ExceptionHandler::InvalidRequest, Message.reservation_not_updated)
  end
end