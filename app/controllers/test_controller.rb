class TestController < ApplicationController
  before_action :set_test, only: :destroy

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    
    tests = Test.order(id: :desc).page(page).per(per_page)
    
    json_response({
      tests: tests,
      meta: {
        current_page: tests.current_page,
        total_pages: tests.total_pages,
        total_count: tests.total_count,
        per_page: tests.limit_value
      }
    }, :ok, Message.test_index)
  end

  def create
    test = CreateTest.new(test_params,schedule_params).call
    json_response(test,:created, Message.test_created)
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
