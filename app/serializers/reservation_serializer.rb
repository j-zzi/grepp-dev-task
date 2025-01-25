class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :participants, :status, :created_at, :updated_at

  attribute :test_schedule do
    TestScheduleSerializer.new(object.test_schedule)
  end

  attribute :user, if: :admin? do
    UserSerializer.new(object.user)
  end

  def admin?
    @instance_options[:context] == :admin
  end
end