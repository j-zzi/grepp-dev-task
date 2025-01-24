class FixForeignKeyColumnNames < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :test_schedules, :tests
    remove_foreign_key :reservations, :test_schedules
    remove_foreign_key :reservations, :users

    rename_column :test_schedules, :tests_id, :test_id
    rename_column :reservations, :test_schedules_id, :test_schedule_id
    rename_column :reservations, :users_id, :user_id

    add_foreign_key :test_schedules, :tests
    add_foreign_key :reservations, :test_schedules
    add_foreign_key :reservations, :users
  end
end