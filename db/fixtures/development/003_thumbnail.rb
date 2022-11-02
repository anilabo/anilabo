require 'csv'

animes = []

CSV.foreach('db/csv/thubnail_from_prime.csv') do |row|
  title = row[2]
  thumbnail_url = row[3]

  anime = Anime.find_by(title:)

  next if thumbnail_url == '-' || anime.nil?

  id = anime.id

  animes << {
    id:,
    thumbnail_url:
  }
end

Anime.seed(animes)
