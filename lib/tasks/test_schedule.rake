namespace :test_schedule do
  desc "Sync number_of_participants with confirmed reservations"
  task sync_participants: :environment do
    require_relative '../../app/batch/test_schedule/sync_participants'
    
    Rails.logger.info "Starting sync participants count at #{Time.current}"
    
    begin
      Batch::TestSchedule::SyncParticipants.execute
    rescue => e
      Rails.logger.error "Batch failed: #{e.message}"
      raise e
    end
    
    Rails.logger.info "Sync completed at #{Time.current}"
  end
end