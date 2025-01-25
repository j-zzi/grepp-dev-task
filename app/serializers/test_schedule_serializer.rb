class TestScheduleSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :deadline, :number_of_participants
end 