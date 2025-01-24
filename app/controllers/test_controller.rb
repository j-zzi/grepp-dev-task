class TestController < ApplicationController
  before_action :set_test, only: :destroy

  def index
    tests = Test.all
    json_response(tests, :ok)
  end

  def create
    test = CreateTest.new(test_params,schedule_params).call
    response = { message: Message.test_created, test: test }
    json_response(response, :created)
  end

  def destroy
    @test.destroy
    head :no_content
  end

  private

  def set_test
    @test = Test.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    raise(ExceptionHandler::NotFound, Message.not_found('Test'))
  end

  def test_params
    params.require(:test).permit(:title, :description)
  end

  def schedule_params
    params.require(:test_schedules).map do |schedule|
      schedule.permit(:start_time, :end_time)
    end
  end
end
