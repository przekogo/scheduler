Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'tasks#index'

  resources :tasks

  get 'generate_modal_form', to: 'tasks#generate_modal_form'
  post 'run_task', to: 'tasks#run_task'
end
