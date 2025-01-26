class Reservation < ApplicationRecord
  VALID_STATUSES = %w[pending confirmed rejected canceled].freeze

  belongs_to :user
  belongs_to :test_schedule

  enum :status, {
    pending: 0, 
    confirmed: 1,  
    rejected: 2,  
    canceled: 3
  }

  validates :user_id, presence: true
  validates :test_schedule_id, presence: true
  validates :participants, presence: true

  validate :within_deadline
  validate :not_exceeding_capacity

  private

  def within_deadline
    return unless test_schedule
    
    if Time.current > test_schedule.deadline
      raise ExceptionHandler::InvalidRequest, Message.deadline_passed
    end
  end

  def not_exceeding_capacity
    return unless test_schedule
    
    current_participants = test_schedule.reservations.confirmed.where.not(id: id).sum(:participants)
    max_capacity = 50_000
    
    if (current_participants + participants) > max_capacity
      raise ExceptionHandler::InvalidRequest, Message.exceeds_capacity
    end
  end

  def check_pending_status
    raise ExceptionHandler::InvalidRequest, Message.not_pending_reservation unless pending?
  end
end