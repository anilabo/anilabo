class UserSerializer < ActiveModel::Serializer
  attributes %i[
    id
    uid
    display_name
    email
    photo_url
    created_at
    updated_at
    followings
    followers
    watched_animes
  ]
  has_many :watching_animes
  has_many :will_watch_animes
  has_many :active_notifications
  has_many :passive_notifications

  def watched_animes
    object.watched_animes.select('*')
  end
end
