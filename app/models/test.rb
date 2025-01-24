class Test < ApplicationRecord
    has_many :test_schedules, dependent: :destroy
end
