class AddIntroductionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :introduction, :text, null: false, default: ""
  end
end