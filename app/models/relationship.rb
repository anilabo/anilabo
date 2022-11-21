class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validate :different_by_target
  validates :followed_id, uniqueness: { scope: :follower_id }

  after_save :create_notification
  after_destroy :delete_notification

  private

    def different_by_target
      errors.add(:base, 'followed_id and follower_id must be different.') if followed_id == follower_id
    end

    def create_notification
      Notification.create!(operative_user_id: follower_id, passive_user_id: followed_id, action: 'follow')
      Notification.create!(operative_user_id: followed_id, passive_user_id: follower_id, action: 'followed', checked: true)
    end

    def delete_notification
      Notification.find_by!(operative_user_id: follower_id, passive_user_id: followed_id, action: 'follow').destroy!
      Notification.find_by!(operative_user_id: followed_id, passive_user_id: follower_id, action: 'followed').destroy!
    end
end
