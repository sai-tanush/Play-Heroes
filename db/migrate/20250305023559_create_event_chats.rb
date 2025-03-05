class CreateEventChats < ActiveRecord::Migration[8.0]
  def change
    create_table :event_chats do |t|
      t.references :play_event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
