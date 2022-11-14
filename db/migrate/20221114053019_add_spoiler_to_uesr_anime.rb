class AddSpoilerToUesrAnime < ActiveRecord::Migration[7.0]
  def change
    add_column :user_animes, :is_spoiler, :boolean, default: false
  end
end
