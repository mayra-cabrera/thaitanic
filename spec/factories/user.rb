FactoryGirl.define do
  factory :user, class: Spree::User do
    email Faker::Internet.email
    password "password"

    after(:create) do |user, evaluator|
      user.spree_roles << create(:role_admin)
      user.save
    end
  end
end