class UserShortInfoSerializer < ActiveModel::Serializer
  attributes %i[
    id
    uid
    display_name
    email
    photo_url
    introduction
    created_at
    updated_at
  ]
end
