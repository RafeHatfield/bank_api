class Account < ActiveRecord::Base
  has_one :api_key

  validates :card_number, presence: true
  validates :pin, presence: true

  after_create :create_api_key

  def balance_dollars
    balance / 100
  end

  def balance_dollars=(bal)
    self.balance = bal * 100
  end

  def withdraw(amount)
    if amount < balance_dollars && amount > 0
      self.balance_dollars = balance_dollars - amount
      save
      return true
    end
    false
  end

  private

  def create_api_key
    ApiKey.create(account: self, token: SecureRandom.hex.to_s)
  end
end
