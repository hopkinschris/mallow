FactoryGirl.define do
  sequence :email do |n|
    "hansel#{n}@mail.com"
  end
  factory :user do
    provider "twitter"
    name "Hansel Magnum"
    email { generate(:email) }
    nickname "hansel"
    location "Sweden"
    waitlist false
    mail_opt true
  end
end
