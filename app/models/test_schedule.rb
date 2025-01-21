class TestSchedule < ApplicationRecord
    belongs_to :test

    has_many :reservations
end
