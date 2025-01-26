class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.account_created
    'Account created successfully'
  end

  def self.login_success
    'Login successful'
  end

  def self.account_not_created
    'Account could not be created'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end

  def self.deadline_passed
    "Reservations are only allowed up to 3 days before the test"
  end

  def self.exceeds_capacity
    "Maximum capacity exceeded"
  end

  def self.invalid_test_schedule
    "Invalid test schedule"
  end

  def self.reservation_index
    "Reservations read successfully"
  end

  def self.reservation_created
    "Reservation created successfully"
  end

  def self.reservation_updated
    "Reservation updated successfully"
  end

  def self.reservation_not_created
    'Reservation could not be created'
  end

  def self.not_pending_reservation
    'Reservation is not pending'
  end

  def self.cannot_update_reservation
    'Cannot update this reservation'
  end

  def self.reservation_not_updated
    'Reservation could not be updated'
  end

  def self.reservation_confirmed
    'Reservation confirmed successfully'
  end

  def self.reservation_rejected
    'Reservation rejected successfully'
  end

  def self.test_created
    'Test created successfully'
  end

  def self.test_updated
    'Test updated successfully'
  end

  def self.test_index
    'Tests read successfully'
  end

  def self.test_not_created
    'Test could not be created'
  end

  def self.invalid_status
    'Invalid status'
  end
end
