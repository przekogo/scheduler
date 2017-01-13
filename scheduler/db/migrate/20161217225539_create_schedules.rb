class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |s|
        s.integer :task_id
        s.integer :day_id
        s.string :execution_hours, null: false

        s.timestamps
    end
  end
end
