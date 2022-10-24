class Anime < ApplicationRecord
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(20)

  enum sex: { men: 0, women: 1, custom: 2 }
  enum season: { winter: 1, spring: 2, summer: 3, fall: 4 }

  has_many :anime_companies
  has_many :companies, through: :anime_companies

  def series
    Anime.where(title_short1:).where.not(public_uid:)
  end
end
