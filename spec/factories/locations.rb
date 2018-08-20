FactoryBot.define do
  factory :location do
    country { Faker::Address.country }
    city { Faker::Address.city }
    region { Faker::Address.state_abbr }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
