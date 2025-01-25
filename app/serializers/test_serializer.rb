class TestSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at
  has_many :test_schedules, serializer: TestScheduleSerializer
end