class DropUserRegistrationRequests < ActiveRecord::Migration[8.0]
  def up
    drop_table :user_registration_requests
  end
end
