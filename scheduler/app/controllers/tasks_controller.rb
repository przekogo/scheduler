class TasksController < ApplicationController
  def index
    set_days_tasks
  end

  def generate_modal_form
    set_days_tasks
    if params[:id]
      @task = @tasks.select{|t| t['id'] == params[:id].to_i}.first
    else
      @task = nil
    end
    respond_to do |format|
      format.js
    end
  end

  def create
    target = 'success.js.erb'
    task = Task.new(task_params)
    if task.save 
      schedule_params.each do |day, hours|
        unless task.add_schedule(day, hours)
          task.destroy
          target = 'error.js.erb'
          break
        end
      end
    end

    if target == 'success.js.erb' then set_days_tasks end
    respond_to do |format|
      format.js{render target}
    end
  end

  def update
    target = 'success.js.erb'
    task = Task.find(task_params[:id])
    if task.update(task_params)
      (0..6).each do |day|
        if schedule_params[day.to_s.to_sym]
          task.add_schedule(day, schedule_params[day.to_s.to_sym])
        else
          task.schedules.try(:find_by_day_id, day).try(:destroy)
        end
      end
    end

    if target == 'success.js.erb' then set_days_tasks end
    respond_to do |format|
      format.js{render target}
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    set_days_tasks
    respond_to do |format|
      format.js{ render 'success.js.erb'}
    end
  end

  def run_task
    task = Task.find(params[:id])
    Schedule.send_request(task.port, task.token, task.executable_path)
    set_days_tasks
    respond_to do |format|
      format.js{ render 'success.js.erb' }
    end
  end

  private

    def set_days_tasks
      @days = Day.all
      @tasks = []
      Task.select('id, name, start_date, end_date, executable_path, port, token').each do |t|
        @tasks << t.as_json.merge('schedules' => Task.find_schedules_for(t.id), 'responses' => Task.find_responses_for(t.id))
      end
    end

    def task_params
      params.require(:task).permit(:id, :name, :start_date, :end_date, :executable_path, :port, :token)
    end

    def schedule_params
      params.require(:schedules).permit(:'0' => [], :'1' => [], :'2' => [], :'3' => [], :'4' => [], :'5' => [], :'6' => [])
    end
end