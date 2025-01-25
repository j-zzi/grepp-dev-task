class TestController < ApplicationController
  before_action :set_test, only: :destroy

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    status = params[:status]  # 'closed' 또는 'ongoing'
  
    tests = Test.order(id: :desc)
    tests = case status
            when 'closed'
              tests.closed
            when 'ongoing'
              tests.ongoing
            else
              tests
            end
  
  tests = tests.page(page).per(per_page)
    
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

  def show
    test = Test.includes(:test_schedules).find(params[:id])
    response = {  
      test: test,
      test_schedules: test.test_schedules
    }
    render json: response, status: :ok
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
