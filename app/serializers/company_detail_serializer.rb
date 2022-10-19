class CompanyDetailSerializer < ActiveModel::Serializer
  attributes %i[
    id
    public_uid
    name
    name_en
    address
    public_url
    created_at
    updated_at
    animes
  ]
end
