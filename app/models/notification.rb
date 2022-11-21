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
end
