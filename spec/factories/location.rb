FactoryGirl.define do
  factory :location do
    name { "#{ Faker::Name.name } #{ Time.zone.now }" }
  end
end
