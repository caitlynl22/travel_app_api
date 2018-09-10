FactoryBot.define do
  factory :trip do
    title { Faker::Lorem.word }
    from { Faker::Date.backward(14) }
    to  { Faker::Date.backward(7) }
    description { Faker::Lorem.paragraph }
    user
  end
end
