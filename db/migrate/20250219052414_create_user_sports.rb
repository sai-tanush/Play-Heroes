class CreateUserSports < ActiveRecord::Migration[8.0]
  def change
    create_table :user_sports do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sports, null: false, foreign_key: true

      t.timestamps
    end
  end
end
