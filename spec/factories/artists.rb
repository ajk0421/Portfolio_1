FactoryBot.define do
  factory :artist do
    name{Faker::Music::RockBand.name}
    furi_gana{"カタカナ"}
    image{Rails.root.join("spec/fixtures/test.jpg").open}
    place{Faker::Address.city}
    profile{Faker::String.random}

  end

  factory :user do
    name{Faker::Name.name}
    email{Faker::Internet.email}
    password{Faker::Alphanumeric.alpha 10}
  end
end
