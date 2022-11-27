class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  enum action: {
    watching: 0,
    will_watch: 1,
    opinion: 2,
    follow: 3
  }

  belongs_to :operative_user, class_name: 'User', foreign_key: 'operative_user_id', optional: true
  belongs_to :passive_user, class_name: 'User', foreign_key: 'passive_user_id', optional: true
  belongs_to :anime, optional: true
  belongs_to :watch_log, class_name: 'UserAnime', foreign_key: 'watch_log_id', optional: true

  validates :action, presence: true
  validates :operative_user_id, presence: true

  with_options if: -> { follow? } do
    validates :passive_user_id, presence: true
  end

  with_options if: -> { watching? || will_watch? || opinion? } do
    validates :anime_id,        presence: true
    validates :watch_log_id,    presence: true
  end
end
