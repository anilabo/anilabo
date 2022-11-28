class User < ApplicationRecord
  has_secure_password(validations: false)

  has_many :user_animes, dependent: :destroy
  has_many :animes, through: :user_animes

  # サブスクライブ機能
  has_many :watched_logs, -> { watched }, class_name: 'UserAnime'
  has_many :watched_animes, through: :watched_logs, source: :anime
  has_many :watching_logs, -> { watching }, class_name: 'UserAnime'
  has_many :watching_animes, through: :watching_logs, source: :anime
  has_many :will_watch_logs, -> { will_watch }, class_name: 'UserAnime'
  has_many :will_watch_animes, through: :will_watch_logs, source: :anime

  # フォロー機能
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 通知・アクティビティ機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'operative_user_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'passive_user_id', dependent: :destroy

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def following_ids
    followings.map(&:id)
  end
end
