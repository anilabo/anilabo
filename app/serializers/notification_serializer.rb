class NotificationSerializer < ActiveModel::Serializer
  attributes %i[
    id
    operative_user
    passive_user
    action
    checked
    created_at
    updated_at
  ]
end
