class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :test_schedule

    enum status: { pending: 0, confirmed: 1, cancelled: 2 }

    validates :user_id, presence: true
    validates :test_schedule_id, presence: true
end
