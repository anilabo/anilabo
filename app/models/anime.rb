class Anime < ApplicationRecord
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(20)

  enum sex: { men: 0, women: 1, custom: 2 }
  enum season: { winter: 1, spring: 2, summer: 3, fall: 4 }

  has_many :anime_companies
  has_many :companies, through: :anime_companies

  has_many :user_animes
  has_many :users, through: :user_animes

  has_many :notifications, dependent: :destroy

  scope :in_order, -> { order(:year, :season) }

  def series
    Anime.where(title_short1:).where.not(public_uid:)
  end

  def thumbnail_url_from
    if thumbnail_url.start_with?('https://m.media-amazon.com/images/')
      'Amazon prime video'
    elsif thumbnail_url == ''
      'Unknown'
    end
  end

  def watched_users
    users.where(user_animes: { progress: 'watched' }).includes(:user_animes).select('*')
  end

  def watching_users
    users.where(user_animes: { progress: 'watching' })
  end

  def will_watch_users
    users.where(user_animes: { progress: 'will_watch' })
  end
end
