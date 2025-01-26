class AdminUpdateReservation
  def initialize(reservation, params)
    @reservation = reservation
    @params = params
    @old_participants = reservation.participants
    @old_schedule = reservation.test_schedule
  end

  def call
    return simple_update unless @reservation.confirmed?
    update_with_participants_sync
  end

  private

  def simple_update
    @reservation.update!(@params)
  end

  def update_with_participants_sync
    ActiveRecord::Base.transaction do
      @reservation.update!(@params)
      
      if schedule_changed?
        @old_schedule.decrement!(:number_of_participants, @old_participants)
        @reservation.test_schedule.increment!(:number_of_participants, @reservation.participants)
      elsif participants_changed?
        diff = @reservation.participants - @old_participants
        @reservation.test_schedule.increment!(:number_of_participants, diff)
      end
    end
  end

  def schedule_changed?
    @old_schedule.id != @reservation.test_schedule_id
  end

  def participants_changed?
    @old_participants != @reservation.participants
  end
end