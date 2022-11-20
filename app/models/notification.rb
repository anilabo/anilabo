class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :operative_user, class_name: 'User', foreign_key: 'operative_user_id', optional: true
  belongs_to :passive_user, class_name: 'User', foreign_key: 'passive_user_id', optional: true
  belongs_to :anime, optional: true
end
