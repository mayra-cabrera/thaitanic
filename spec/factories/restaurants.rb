# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant do
    name Faker::Company.name
    description Faker::Lorem.paragraph
    address Faker::Address.street_name
    phone Faker::PhoneNumber.short_phone_number
    sequence :code do |n|
      "REST-00#{n}"
    end
  end
end
