class Test < ApplicationRecord
    VALID_STATUSES = %w[closed ongoing].freeze
    
    has_many :test_schedules, dependent: :destroy
    has_many :reservations, through: :test_schedules

    validates :title, presence: true
    validates :description, presence: true

    scope :unavailable, -> {
      where.not(
        id: Test.joins(:test_schedules).where(
          'test_schedules.number_of_participants < ? AND test_schedules.deadline >= ?',
          50000,
          Time.current
        )
      )
    }
  
    scope :available, -> {
      where(
        id: Test.joins(:test_schedules).where(
          'test_schedules.number_of_participants < ? AND test_schedules.deadline >= ?',
          50000,
          Time.current
        )
      )
    }

    def destroy
      raise ExceptionHandler::InvalidRequest, Message.cannot_delete_test_with_reservations if has_reservations?
      super
    end

    private

    def has_reservations?
      reservations.exists?
    end
end
