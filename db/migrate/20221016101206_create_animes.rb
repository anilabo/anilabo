class CreateAnimes < ActiveRecord::Migration[7.0]
  def change
    create_table :animes do |t|
      t.string :public_uid, null: false
      t.string :title, null: false, default: ""
      t.string :title_short1, default: ""
      t.string :title_short2, default: ""
      t.string :title_short3, default: ""
      t.string :title_en, null: false, default: ""
      t.string :public_url, null: false, default: ""
      t.string :twitter_account, null: false, default: ""
      t.string :twitter_hash_tag, null: false, default: ""
      t.integer :cours_id, null: false, default: 0
      t.integer :sex, null: false, default: 0
      t.integer :sequel, null: false, default: 0
      t.integer :city_code, null: false, default: 0
      t.string :city_name, null: false, default: ""
      t.string :thumbnail_url, null: false, default: ""
      t.integer :year, null: false
      t.integer :season, null: false

      t.timestamps
    end
    add_index :animes, :public_uid, unique: true
    add_index :animes, :title, unique: true
    add_index :animes, :title_en
    add_index :animes, :title_short1
    add_index :animes, :title_short2
    # add_index :animes, :title_short3 # title_short3はあまり使わない
    add_index :animes, :thumbnail_url
    add_index :animes, [:year, :season]
  end
end
