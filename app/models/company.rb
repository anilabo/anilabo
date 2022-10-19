class Company < ApplicationRecord
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(20)

  has_many :anime_companies
  has_many :animes, through: :anime_companies
end
