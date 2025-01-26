module Batch
  module TestSchedule
    class SyncParticipants
      def self.execute
        new.execute
      end

      def execute
        fixed_count = 0
        error_count = 0
        
        ::TestSchedule.find_each do |schedule|
          begin
            confirmed_total = schedule.reservations.confirmed.sum(:participants)
            
            if schedule.number_of_participants != confirmed_total
              Rails.logger.info "Fixing TestSchedule##{schedule.id}: #{schedule.number_of_participants} -> #{confirmed_total}"
              schedule.update!(number_of_participants: confirmed_total)
              fixed_count += 1
            end
          rescue => e
            error_count += 1
            Rails.logger.error "Error with TestSchedule##{schedule.id}: #{e.message}"
          end
        end

        Rails.logger.info "Results: Fixed #{fixed_count} records, Errors: #{error_count}"
      end
    end
  end
end