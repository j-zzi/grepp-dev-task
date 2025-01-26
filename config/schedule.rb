ENV.each_pair do |key, value|
  env key, value
end

env :environment, ENV['RAILS_ENV']
set :output, 'log/cron.log'

every 1.day, at: '3:00 am' do
  rake 'test_schedule:sync_participants'
end

every 'sunday', at: '3:00 am' do
  rake 'test_schedule:sync_participants'
end