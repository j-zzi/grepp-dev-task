module Filterable
  extend ActiveSupport::Concern

  private

  def filter_by_status(reservations, status)
    return reservations if status.blank? || status == 'all'
    raise ExceptionHandler::InvalidRequest, 'Invalid status' unless Reservation.statuses.key?(status)
    
    reservations.where(status: status)
  end

  def filter_schedules_by_availability(schedules, available)
    return schedules if available.blank? || available == 'all'
    raise ExceptionHandler::InvalidRequest, 'Invalid availability' unless ['true', 'false'].include?(available)
    
    case available
    when 'true'
      schedules.available
    when 'false'
      schedules.unavailable
    end
  end

  def filter_tests_by_availability(tests, available)
    return tests if available.blank? || available == 'all'
    raise ExceptionHandler::InvalidRequest, 'Invalid availability' unless ['true', 'false'].include?(available)
    
    case available
    when 'true'
      tests.available
    when 'false'
      tests.unavailable
    end
  end
end