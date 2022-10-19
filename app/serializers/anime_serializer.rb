class AnimeSerializer < ActiveModel::Serializer
  attributes %i[
    id
    public_uid
    title
    thumbnail_url
    title_en
    title_short1
    title_short2
    title_short3
    public_url
    twitter_account
    twitter_hash_tag
    created_at
    updated_at
    series
    companies
  ]
end