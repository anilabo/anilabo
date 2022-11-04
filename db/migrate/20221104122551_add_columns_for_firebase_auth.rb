class AddColumnsForFirebaseAuth < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :uid, :string, null: false
    add_index :users, :uid, unique: true
    add_column :users, :display_name, :string, null: false
    add_column :users, :photo_url, :string, null: false
  end
end
