class RenameTable < ActiveRecord::Migration[8.0]
  def change
    rename_table :user_sports, :sports_users
    rename_column :sports_users, :sports_id, :sport_id
  end
end
