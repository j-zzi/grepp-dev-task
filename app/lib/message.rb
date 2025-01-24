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

  def self.reservation_not_found
    "Reservation not found"
  end

  def self.reservation_created
    "Reservation created successfully"
  end

  def self.reservation_updated
    "Reservation updated successfully"
  end

  def self.reservation_deleted
    "Reservation deleted successfully"
  end
end