class CreateTest
  def initialize(test_params,shedule_params)
    @test_params = test_params
    @shedule_params = shedule_params
  end

  def call
    ActiveRecord::Base.transaction do
      create_test_with_schedules
    end
  rescue ActiveRecord::RecordInvalid => e
    raise ExceptionHandler::InvalidRequest, Message.test_not_created
  end
  
  private
  
  def create_test_with_schedules
    test = Test.create!(@test_params)
    
    @shedule_params.each  do |shedule_param|
      test.test_schedules.create!(shedule_param)
    end
  
    test
  end
end

