class CreateEventParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :event_participants do |t|
      t.references :play_event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
