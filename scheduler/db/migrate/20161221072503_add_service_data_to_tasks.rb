class AddServiceDataToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :port, :string
    add_column :tasks, :token, :string
  end
end
