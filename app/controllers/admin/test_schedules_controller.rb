class Admin::TestSchedulesController < ApplicationController
  before_action :set_test
  before_action :set_test_schedule, only: :destroy

  def create
    test_schedule = @test.test_schedules.create!(test_schedule_params)
    json_response(test_schedule, :created, Message.test_schedule_created)
  end

  def destroy
    @test_schedule.destroy!
    head :no_content
  end

  private

  def set_test
    @test = Test.find(params[:test_id])
  end

  def set_test_schedule
    @test_schedule = @test.test_schedules.find(params[:id])
  end

  def test_schedule_params
    params.require(:test_schedule).permit(:start_time, :end_time)
  end
end
