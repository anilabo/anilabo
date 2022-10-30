require 'csv'

namespace :thumbnail do
  desc 'サムネイルURLのインポート'

  task import: :environment do
    animes = []

    CSV.foreach('db/csv/thubnail_from_prime.csv') do |row|
      title = row[2]
      thumbnail_url = row[3]

      anime = Anime.find_by(title:)
      next if thumbnail_url == '-' || anime.nil?

      public_uid = anime.public_uid

      animes << {
        public_uid:,
        thumbnail_url:
      }

      anime.update!(thumbnail_url:)
    end
  end
end
