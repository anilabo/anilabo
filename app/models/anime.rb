class Anime < ApplicationRecord
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(20)

  enum sex: { "men": 0, "women": 1, "custom": 2 }
  enum season: { "winter": 1, "spring": 2, "summber": 3, "fall": 4 }
end
