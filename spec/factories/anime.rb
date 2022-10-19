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
end
