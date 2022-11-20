class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :operative_user_id, null: false
      t.integer :passive_user_id                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
      t.integer :anime_id
      t.integer :watch_log_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
    add_index :notifications, :operative_user_id
    add_index :notifications, :passive_user_id
    add_index :notifications, :anime_id
    add_index :notifications, :watch_log_id
  end
end
