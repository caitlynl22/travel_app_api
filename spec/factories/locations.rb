FactoryBot.define do
  factory :location do
    country { "Italy" }
    city { Faker::Address.city }
    region { Faker::Address.state_abbr }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
