class UserAnime < ApplicationRecord
  enum progress: { watched: 0, watching: 1, will_watch: 2 }
  belongs_to :user
  belongs_to :anime

  validates :progress, presence: true

  with_options if: :watched? do
    validates :opinion,        presence: true
    validates :finished_at,    presence: true
  end
end
