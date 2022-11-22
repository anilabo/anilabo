class UserAnime < ApplicationRecord
  enum progress: { watched: 0, watching: 1, will_watch: 2 }
  belongs_to :user
  belongs_to :anime

  has_many :notifications, foreign_key: 'watch_log_id', dependent: :destroy

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

  after_save :create_notification

  scope :watched, -> { where(progress: 'watched') }
  scope :watching, -> { where(progress: 'watching') }
  scope :will_watch, -> { where(progress: 'will_watch') }

  private

    def delete_opinion
      self.opinion = nil
    end

    def delete_finished_at
      self.finished_at = nil
    end

    def reset_is_spoiler
      self.is_spoiler = false
    end

    def create_notification
      action = progress == 'watched' ? 'opinion' : progress
      Notification.create!(operative_user_id: user_id, anime_id:, watch_log_id: id, action:)
    end
end
