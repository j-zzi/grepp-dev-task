class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.integer :participants
      t.integer :status
      t.references :test_schedules, :users, foreign_key: true

      t.timestamps
    end
  end
end
