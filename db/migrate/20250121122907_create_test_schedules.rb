class CreateTestSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :test_schedules do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :deadline
      t.integer :number_of_participants
      t.references :tests, foreign_key: true

      t.timestamps
    end
  end
end
