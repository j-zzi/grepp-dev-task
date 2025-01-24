class CreateReservation
  def initialize(user, test_schedule_id, participants)
    @user = user
    @test_schedule_id = test_schedule_id
    @participants = participants
  end

  def call
    test_schedule = find_test_schedule
    create_reservation(test_schedule)
  end

  private

  attr_reader :user, :test_schedule_id, :participants

  def find_test_schedule
    TestSchedule.find(test_schedule_id)
  rescue ActiveRecord::RecordNotFound
    raise(ExceptionHandler::InvalidRequest, Message.not_found('Test schedule'))
  end

  def create_reservation(test_schedule)
    user.reservations.create!(
      test_schedule: test_schedule,
      participants: participants
    )
  rescue ActiveRecord::RecordInvalid => e
    raise(ExceptionHandler::InvalidRequest, Message.reservation_not_created)
  end
end
