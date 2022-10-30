class AnimeSerializer < ActiveModel::Serializer
  attributes %i[
    id
    public_uid
    title
    title_en
    thumbnail_url
    thumbnail_url_from
    year
    season
    created_at
    updated_at
  ]
end
