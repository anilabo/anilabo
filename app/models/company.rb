class Company < ApplicationRecord
  has_many :anime_companies
  has_many :animes, through: :anime_companies
end
