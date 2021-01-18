FactoryBot.define do
  factory :account do
    name { Faker::FunnyName.name }
    balance { Faker::Number.number(digits: 3) }
    account_number { Faker::Number.number(digits: 10) }
    token { Faker::Code.asin }
  end
end
