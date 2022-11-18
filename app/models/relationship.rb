class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validate :different_by_target
  validates :followed_id, uniqueness: { scope: :follower_id }

  private

    def different_by_target
      errors.add(:base, 'followed_id and follower_id must be different.') if followed_id == follower_id
    end
end
