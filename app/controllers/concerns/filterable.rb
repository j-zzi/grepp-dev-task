module Filterable
  extend ActiveSupport::Concern

  private

  def filter_by_status(reservations, status)
    return reservations if status.blank? || status == 'all'
    raise ExceptionHandler::InvalidRequest, 'Invalid status' unless Reservation.statuses.key?(status)
    
    reservations.where(status: status)
  end

  def filter_by_availability(schedules, available)
    return schedules if available.blank? || available == 'all'
    raise ExceptionHandler::InvalidRequest, 'Invalid availability' unless ['true', 'false'].include?(available)
    
    case available
    when 'true'
      schedules.available
    when 'false'
      schedules.unavailable
    end
  end
end