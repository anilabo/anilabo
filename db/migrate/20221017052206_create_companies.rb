class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :public_uid, null: false
      t.string :name, null: false
      t.string :public_url, default: ""
      t.string :address, default: ""

      t.timestamps
    end
    add_index :companies, :public_uid, unique: true
    add_index :companies, :name
  end
end
