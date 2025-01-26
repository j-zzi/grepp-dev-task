module Filterable
  extend ActiveSupport::Concern

  private

  def filter_by_status(reservations, status)
    return reservations if status.blank? || status == 'all'
    raise ExceptionHandler::InvalidRequest, 'Invalid status' unless Reservation.statuses.key?(status)
    
    reservations.where(status: status)
  end
end