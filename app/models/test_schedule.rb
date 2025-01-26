class TestSchedule < ApplicationRecord
  belongs_to :test
  has_many :reservations

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_before_end_time
  validate :deadline_must_be_future
  
  before_validation :set_default_values
  
  MAX_CAPACITY = 50_000

  scope :ordered, -> { order(start_time: :asc) }
  scope :available, -> { where('deadline > ? AND number_of_participants < ?', Time.current, MAX_CAPACITY) }
  scope :unavailable, -> { where('deadline <= ? OR number_of_participants >= ?', Time.current, MAX_CAPACITY) }

  def destroy
    raise ExceptionHandler::InvalidRequest, Message.test_schedule_has_reservations if has_reservations?
    super
  end

  private

  def set_default_values
    self.deadline ||= start_time - 3.days
    self.number_of_participants ||= 0
  end

  def start_time_before_end_time
    return if start_time.blank? || end_time.blank?
    
    if start_time >= end_time
      raise ExceptionHandler::InvalidRequest, Message.invalid_test_schedule_time
    end
  end

  def deadline_must_be_future
    return if deadline.blank?

    if deadline <= Time.current
      raise ExceptionHandler::InvalidRequest, Message.invalid_test_schedule_deadline
    end
  end

  def has_reservations?
    reservations.exists?
  end
end
