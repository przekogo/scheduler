class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :task_responses do |t|
      t.integer :task_id
      t.string :code
      t.string :message
      t.timestamps
    end
  end
end
