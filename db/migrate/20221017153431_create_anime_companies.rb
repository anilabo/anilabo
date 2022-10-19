class CreateAnimeCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :anime_companies do |t|
      t.references :company, null: false, foreign_key: true
      t.references :anime, null: false, foreign_key: true

      t.timestamps
    end
  end
end
