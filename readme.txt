sql database should be available on localhost for user root without password. If it is not possible please edit scheduler/config/database.yml
in scheduler dir run in order: 'bundle install' 'rake db:migrate db:seed'
in scheduler_service dir run: 'bundle install'
to run tests run 'bundle exec rspec' in each of the two dirs separately
to start the service run "bundle exec puma -C config/puma.rb" in scheduler_service dir (PORT environmental variable can be set to run on specific port, default 3001, needed to run multiple instances of the service). token will be generated if not present and displayed. To generate a new token delete file config/token.txt
to start the webapp run "bundle exec puma -C config/puma.rb" in scheduler dir. It is accessible on localhost:3000 via a web browser
to start the agent run "rake check_pending_tasks" in scheduler dir. It will periodically send requests to the service, the period can be changed in scheduler/config.application.yml (default 900sec, requires restart)