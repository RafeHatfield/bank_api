FactoryGirl.define do
  factory :account do
    card_number { Faker::Bitcoin.address }
    pin { rand(1000...9999) }
    balance 10_000
  end

  factory :api_key do
    account
    token { Faker::Bitcoin.address }
  end
end
