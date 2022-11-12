class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :user_animes, dependent: :destroy
  has_many :animes, through: :user_animes

  def watched_animes
    animes.where(user_animes: { progress: 'watched' }).includes(:user_animes).select('*')
  end

  def watching_animes
    animes.where(user_animes: { progress: 'watching' })
  end

  def will_watch_animes
    animes.where(user_animes: { progress: 'will_watch' })
  end
end
