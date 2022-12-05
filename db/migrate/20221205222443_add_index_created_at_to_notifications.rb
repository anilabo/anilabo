class AddIndexCreatedAtToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_index(:notifications, :created_at)
  end
end
