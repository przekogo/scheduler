class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
        t.string :name
        t.date :start_date
        t.date :end_date
        t.string :executable_path
        
        t.timestamps
    end
  end
end
