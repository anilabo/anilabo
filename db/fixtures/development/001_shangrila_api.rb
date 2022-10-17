require 'csv'

animes = []

CSV.foreach('db/csv/shangrila.csv') do |row|
  animes << {
    year: row[0].to_i,
    season: row[1].to_i,
    title: row[2],
    title_short1: row[3],
    title_short2: row[4],
    title_short3: row[5],
    title_en: row[6],
    public_url: row[7],
    twitter_account: row[8],
    twitter_hash_tag: row[9],
    cours_id: row[10].to_i,
    sex: row[11].to_i,
    sequel: row[12].to_i,
    city_code: row[13].to_i,
  }
end

Anime.seed(animes)
