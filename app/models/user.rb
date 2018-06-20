class User < ActiveRecord::Base
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_many :events
  has_many :events_joined, through: :attendees, source: :event

  validates :first_name, :last_name, :email, :city, :state, :password, presence: true
  validates :first_name, :last_name, length: { in: 2..25 }
  validates :password, length: { minimum: 8 }
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX }

  before_save :downcase_fields

   def downcase_fields
      self.email.downcase!
   end
end
