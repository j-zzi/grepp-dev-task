class TestSchedule < ApplicationRecord
  belongs_to :test
  has_many :reservations

  validates :start_time, presence: true
  validates :end_time, presence: true

  before_validation :set_default_values

  private

  def set_default_values
    self.deadline ||= start_time - 3.days
    self.number_of_participants ||= 0
  end
end
