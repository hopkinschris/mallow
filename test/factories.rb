FactoryGirl.define do
  sequence :name do |n|
    "Hansel#{n}"
  end
  sequence :email do |n|
    "hansel#{n}@mail.com"
  end
  factory :user do
    provider "twitter"
    name { generate(:name) }
    email { generate(:email) }
    nickname "hansel"
    location "Sweden"
    waitlist false
    mail_opt true
  end
end
