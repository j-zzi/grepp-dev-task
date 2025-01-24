class UpdateReservation
  def initialize(reservation, params)
    @reservation = reservation
    @params = params
  end

  def call
    check_reservation_status
    update_reservation
  end

  private

  attr_reader :reservation, :params

  def check_reservation_status
    unless reservation.pending? || reservation.confirmed?
      raise(ExceptionHandler::InvalidRequest, Message.cannot_update_reservation)
    end
  end

  def update_reservation
    reservation.update!(params)
  rescue ActiveRecord::RecordInvalid => e
    raise(ExceptionHandler::InvalidRequest, reservation.errors.full_messages.join(', '))
  end
end