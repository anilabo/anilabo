class CompanySerializer < ActiveModel::Serializer
  attributes %i[
    id
    public_uid
    name
    name_en
    created_at
    updated_at
  ]
end
