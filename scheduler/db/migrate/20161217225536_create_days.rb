class CreateDays < ActiveRecord::Migration[5.0]
  def change
    create_table :days do |d|
        d.string :name
    end
  end
end
