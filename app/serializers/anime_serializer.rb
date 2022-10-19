class AnimeSerializer < ActiveModel::Serializer
  attributes %i[
    id
    public_uid
    title
    title_en
    thumbnail_url
    year
    season
    created_at
    updated_at
  ]
end
