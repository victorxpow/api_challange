FactoryBot.define do
  factory :account do
    name { Faker::FunnyName.name }
    balance { 100 }
    account_number { Faker::Number.number(digits: 4) }
    token { Faker::Code.asin }
  end
end
