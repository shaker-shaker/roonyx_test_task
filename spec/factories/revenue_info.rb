FactoryBot.define do
  factory :revenue_info do
    trade_date { Faker::Date.between(10.days.ago, Date.today) }
    revenue { Faker::Number.decimal(2, 3) }

    association :product, factory: :product
  end
end
