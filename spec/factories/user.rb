FactoryBot.define do
  factory :user do
    uid { 'wildkanikani' }
    display_name { '野生のミシシッピズワイガニ' }
    email { 'wild.kanikani@example.com' }
    photo_url { 'wild-kanikani.jpg' }
  end

  factory :provisional_user, class: "User" do
    sequence(:uid)             { |n| "test#{n}" }
    sequence(:display_name)    { |n| "test#{n}"}
    sequence(:email)           { |n| "test#{n}@example.com" }
    sequence(:photo_url)       { |n| "test#{n}.jpg"}
  end
end
