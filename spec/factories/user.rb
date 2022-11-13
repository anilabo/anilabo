FactoryBot.define do
  factory :user do
    uid { 'wildkanikani' }
    display_name { '野生のミシシッピズワイガニ' }
    email { 'wild.kanikani@example.com' }
    photo_url { 'wild-kanikani.jpg' }
  end
end