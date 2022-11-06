class CreateUserAnimes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_animes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :anime, null: false, foreign_key: true

      t.integer :progress, null: false, default: 0
      t.text :opinion
      t.datetime :finished_at

      t.timestamps
    end
  end
end
