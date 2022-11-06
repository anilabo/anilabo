class UserAnime < ApplicationRecord
  enum progress: { watched: 0, watching: 1, will_watch: 2 }
  belongs_to :user
  belongs_to :anime
end
