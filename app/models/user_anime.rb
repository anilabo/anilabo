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

  before_save :delete_notifications_when_change_from_watched_and_create_notification

  scope :watched, -> { where(progress: 'watched').order(created_at: :desc) }
  scope :watching, -> { where(progress: 'watching').order(created_at: :desc) }
  scope :will_watch, -> { where(progress: 'will_watch').order(created_at: :desc) }

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

    def delete_notifications_when_change_from_watched_and_create_notification
      n = Notification.where(operative_user_id: user_id, anime_id:)
      n.destroy_all if n[0] && n.first.action == 'opinion'
      create_notification
    end

    def create_notification
      action = progress == 'watched' ? 'opinion' : progress
      Notification.create!(operative_user_id: user_id, anime_id:, watch_log_id: id, action:)
    end
end
