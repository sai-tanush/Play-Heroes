class CreateJoinRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :join_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :play_event, null: false, foreign_key: true
      t.string :status, default: 'pending'
      t.text :message
      t.timestamps

      t.index [:user_id, :play_event_id], unique: true
    end
  end
end
