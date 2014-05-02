class ApiKey < ActiveRecord::Base
  belongs_to :account

  validates :account, presence: true
  validates :token, presence: true

  # before_create :generate_token

  private

  # def generate_token
  #   # loop do
  #   #   self.token = SecureRandom.hex.to_s
  #   #   break token unless self.class.exists?(token: token)
  #   # end
  # end
end
