# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    account nil
    event "MyString"
    amount 1
  end
end
