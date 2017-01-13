desc "Handle pending tasks"
task check_pending_tasks: :environment do
  while 1
    puts ENV['check_frequency']
    Schedule.process_current_tasks
    sleep ENV['check_frequency'].to_i
  end
end