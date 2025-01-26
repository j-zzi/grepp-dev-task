namespace :scheduler do
  desc "Update crontab with whenever"
  task update: :environment do
    puts "Updating cron schedule..."
    system "bundle exec whenever --update-crontab"
    puts "Cron schedule updated!"
  end

  desc "Clear crontab"
  task clear: :environment do
    puts "Clearing cron schedule..."
    system "bundle exec whenever --clear-crontab"
    puts "Cron schedule cleared!"
  end

  desc "Show current crontab"
  task show: :environment do
    system "crontab -l"
  end
end