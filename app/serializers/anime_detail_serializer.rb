class AnimeDetailSerializer < ActiveModel::Serializer
  attributes %i[
    id
    public_uid
    title
    thumbnail_url
    thumbnail_url_from
    title_en
    title_short1
    title_short2
    title_short3
    public_url
    twitter_account
    twitter_hash_tag
    city_code
    city_name
    sequel
    year
    season
    created_at
    updated_at
    series
    companies
    watched_users
    watching_users
    will_watch_users
  ]
end
