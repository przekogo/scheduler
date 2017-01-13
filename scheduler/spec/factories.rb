FactoryGirl.define do
  factory :task do
    id 10
    name "testask"
    start_date  Date.yesterday.noon
    end_date Date.tomorrow.noon
    port '3001'
    token '26f7c972e264a138af0ec3e604ef2540'
    executable_path 'testask.rb'
    created_at 2.days.ago.noon
  end
  factory :schedule do
    id 7
    task_id 10
    day_id 3
    execution_hours "2,3,4"
    created_at 2.days.ago.noon
  end
  factory :task_response_200, class: TaskResponse do
    id 90
    task_id 10
    code '200'
    message 'ok'
    created_at 2.days.ago.noon
  end
  factory :task_response_400, class: TaskResponse do
    id 90
    task_id 10
    code '400'
    message 'ok'
    created_at 2.days.ago.noon
  end
end