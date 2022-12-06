class AddIndexCreatedAtToUserAnimes < ActiveRecord::Migration[7.0]
  def change
    add_index(:user_animes, :created_at)
  end
end
