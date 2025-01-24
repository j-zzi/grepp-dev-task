class User < ApplicationRecord
    has_secure_password
    has_many :reservations

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }

    enum :role, { user: 0, admin: 1 }
end
