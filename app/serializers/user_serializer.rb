class UserSerializer < ActiveModel::Serializer
  attributes %i[
    id
    uid
    display_name
    email
    photo_url
    created_at
    updated_at
    watched_animes
    watching_animes
    will_watch_animes
    followings
    followers
  ]
  has_many :active_notifications
  has_many :passive_notifications
end
