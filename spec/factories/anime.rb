FactoryBot.define do
  factory :anime do
    title { "SPY×FAMILY" }
    title_short1 { "SPY×FAMILY" }
    title_short2 { "" }
    title_short3 { "" }
    title_en { "" }
    public_url { "https://spy-family.net/" }
    twitter_account { "spyfamily_anime" }
    twitter_hash_tag { "スパイファミリー" }
    cours_id { 0 }
    sex { 0 }
    sequel { 2 }
    city_code { 0 }
    city_name { "" }
    year { 2022 }
    season { 4 }
  end

  factory :provisional_anime, class: 'Anime' do
    sequence(:title) { |n| "anime#{n}" }
    sequence(:title_short1) { |n| "anime#{n}_title_short_1" }
    sequence(:title_short2) { |n| "anime#{n}_title_short_2" }
    sequence(:title_short3) { |n| "anime#{n}_title_short_3" }
    sequence(:title_en) { |n| "anime#{n}title_en" }
    sequence(:public_url) { |n| "anime#{n}_public_url" }
    sequence(:twitter_account) { |n| "anime#{n}_twitter_account" }
    sequence(:twitter_hash_tag) { |n| "anime#{n}_title_hash_tag" }
    cours_id { 0 }
    sex { 0 }
    sequel { 2 }
    city_code { 0 }
    city_name { "" }
    year { 2022 }
    season { 4 }
  end
end
