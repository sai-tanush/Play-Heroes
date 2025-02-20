class CreateSportSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sport_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sport, null: false, foreign_key: true
      t.integer :duration_minutes
      t.date :played_on

      t.timestamps
    end
  end
end
