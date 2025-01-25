class Test < ApplicationRecord
    has_many :test_schedules, dependent: :destroy

    validates :title, presence: true
    validates :description, presence: true

    scope :closed, -> {
      where.not(
        id: Test.joins(:test_schedules).where(
          'test_schedules.number_of_participants < ? AND test_schedules.deadline >= ?',
          50000,
          Time.current
        )
      )
    }
  
    scope :ongoing, -> {
      where(
        id: Test.joins(:test_schedules).where(
          'test_schedules.number_of_participants < ? AND test_schedules.deadline >= ?',
          50000,
          Time.current
        )
      )
    }
end
