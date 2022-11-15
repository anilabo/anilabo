class UserAnime < ApplicationRecord
  enum progress: { watched: 0, watching: 1, will_watch: 2 }
  belongs_to :user
  belongs_to :anime

  validates :progress, presence: true

  with_options if: :watched? do
    validates :opinion,        presence: true
    validates :finished_at,    presence: true
  end

  with_options unless: :watched? do
    after_validation :delete_opinion
    after_validation :delete_finished_at
    after_validation :reset_is_spoiler
  end

  def delete_opinion
    self.opinion = nil
  end

  def delete_finished_at
    self.finished_at = nil
  end

  def reset_is_spoiler
    self.is_spoiler = false
  end
end
