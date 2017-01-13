class Task < ActiveRecord::Base
  has_many :schedules, dependent: :destroy
  has_many :days, through: :schedules
  has_many :task_responses, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :start_date, :end_date, :executable_path, :port, :token, presence: true

  def add_schedule(day, hours)
    Schedule.find_or_initialize_by(task_id: self.id, day_id: day).update(task_id: self.id, day_id: day, execution_hours: hours.join(','))
  end

  def self.find_schedules_for(id)
    Task.joins(:schedules).joins('left join days on schedules.day_id = days.id').select('days.id as day, schedules.execution_hours').where(id: id).as_json(only: [:day, :execution_hours]).map {|k| k = {k['day']=>k['execution_hours'].split(',').map(&:to_i)}}.reduce({}, :update)
  end
  def self.find_responses_for(id)
    Task.joins(:task_responses).select('code, message, task_responses.created_at').where(id: id).order('task_responses.created_at desc').as_json(only: [:code, :message, :created_at])
  end
end
