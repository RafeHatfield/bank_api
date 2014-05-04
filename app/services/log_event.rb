class LogEvent
  def self.call(account, event, amount = 0)
    Event.create(account: account, event: event, amount: amount)
    Rails.logger.info "Card: #{account.card_number} Event: #{event} Amount: #{amount}"
  end
end
