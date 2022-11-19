class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :user_animes, dependent: :destroy
  has_many :animes, through: :user_animes

  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def watched_animes
    animes.where(user_animes: { progress: 'watched' }).includes(:user_animes).select('*').order('user_animes.created_at DESC')
  end

  def watching_animes
    animes.where(user_animes: { progress: 'watching' }).order('user_animes.created_at DESC')
  end

  def will_watch_animes
    animes.where(user_animes: { progress: 'will_watch' }).order('user_animes.created_at DESC')
  end
end
