class TestsController < ApplicationController
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    status = params[:status]
  
    tests = Test.order(id: :desc)
    tests = tests.public_send(status)
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

  private

  def set_test
    @test = Test.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    raise(ExceptionHandler::NotFound, Message.not_found('Test'))
  end
end