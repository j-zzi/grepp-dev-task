class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :test_schedule

  enum status: {
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
    
    deadline = test_schedule.start_time - 3.days
    if Time.current > deadline
      errors.add(:base, Message.deadline_passed)
    end
  end

  def not_exceeding_capacity
    return unless test_schedule
    
    current_participants = test_schedule.reservations.confirmed.where.not(id: id).sum(:participants)
    max_capacity = 50_000
    
    if (current_participants + participants) > max_capacity
      errors.add(:base, Message.exceeds_capacity)
    end
  end
end