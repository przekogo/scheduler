class Schedule < ActiveRecord::Base
  belongs_to :task
  belongs_to :day

  validates :execution_hours, presence: true
  validates :task_id, uniqueness: {scope: [:day_id]}

  def self.process_current_tasks
    now = DateTime.now # store current time to prevent it from changing during the search below
    # find all schedules for today closest to the time defined
    schedules = Task.where('start_date < ? and end_date > ?', now, now).joins(:schedules).where('schedules.day_id = ? or (schedules.day_id = 6 and ? = -1)', now.wday-1, now.wday-1).select('tasks.executable_path, tasks.port, tasks.token, schedules.day_id, schedules.execution_hours')
    schedules.each do |s|
      s.execution_hours.split(',').map(&:to_i).each do |hour| # check if schedule's execution hour matches current time
        if (0..(ENV['check_frequency'].to_i)/60) === ((now - (DateTime.new(now.year, now.month, now.day, hour, 0, 0, now.zone)))*1440).to_i
          # send api request to server
          logger.info 'sending request:' + s.inspect
          self.send_request(s[:port], s[:token], s[:executable_path])
        end
      end
    end
  end

  def self.send_request(port, token, exec)
    response = begin
      RestClient.post('localhost:'+port+'/start_task', {task: {executable_path: exec, token: token}}, headers={})
    rescue RestClient::ExceptionWithResponse => e
      e.response
    rescue Errno::ECONNREFUSED => e
      {code: '111', message: 'Connection refused'}
    end
    handle_response(response, exec)
  end

  private

    def self.handle_response(response, exec)
      if response.class != {}.class then response = eval(response).merge(code: response.code) end
      Task.find_by_executable_path(exec).task_responses << TaskResponse.new(code: response[:code].to_s, message: response[:message])
    end
end