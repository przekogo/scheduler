Rails.application.routes.draw do
  post 'start_task', to: 'launcher#start_task'
end