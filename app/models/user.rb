class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :user_animes, dependent: :destroy
  has_many :animes, through: :user_animes

  has_many :watched_logs, -> { watched }, class_name: 'UserAnime'
  has_many :watched_animes, through: :watched_logs, source: :anime
  has_many :watching_logs, -> { watching }, class_name: 'UserAnime'
  has_many :watching_animes, through: :watching_logs, source: :anime
  has_many :will_watch_logs, -> { will_watch }, class_name: 'UserAnime'
  has_many :will_watch_animes, through: :will_watch_logs, source: :anime

  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'operative_user_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'passive_user_id', dependent: :destroy

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
