class TestScheduleSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time

  attribute :deadline, if: :list?
  attribute :number_of_participants, if: -> {list? || admin?}
  
  def list?
    @instance_options[:context] == :list
  end

  def admin?
    @instance_options[:context] == :admin
  end
end
