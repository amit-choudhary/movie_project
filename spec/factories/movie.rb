FactoryGirl.define do
  factory :movie do
    title { "#{ Faker::Name.name } #{ Time.zone.now }" }
  end
end
