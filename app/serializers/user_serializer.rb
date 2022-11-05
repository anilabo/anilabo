class UserSerializer < ActiveModel::Serializer
  attributes %i[
    id
    uid
    display_name
    email
    photo_url
    created_at
    updated_at
  ]
end
