class NotificationSerializer < ActiveModel::Serializer
  attributes %i[
    id
    operative_user
    passive_user
    action
    checked
    anime
    created_at
    updated_at
  ]
end
