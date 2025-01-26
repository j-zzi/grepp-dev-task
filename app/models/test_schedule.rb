class TestSchedule < ApplicationRecord
  belongs_to :test
  has_many :reservations

  validates :start_time, presence: true
  validates :end_time, presence: true

  before_validation :set_default_values

  MAX_CAPACITY = 50_000

  scope :ordered, -> { order(start_time: :asc) }
  scope :available, -> { where('deadline > ? AND number_of_participants < ?', Time.current, MAX_CAPACITY) }
  scope :unavailable, -> { where('deadline <= ? OR number_of_participants >= ?', Time.current, MAX_CAPACITY) }

  private

  def set_default_values
    self.deadline ||= start_time - 3.days
    self.number_of_participants ||= 0
  end
end
