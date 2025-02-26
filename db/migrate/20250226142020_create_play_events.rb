class CreatePlayEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :play_events do |t|
      t.references :sport, null: false, foreign_key: true
      t.references :host, null: false, foreign_key: { to_table: :users }
      t.string :sport_type
      t.string :event_location
      t.string :event_category
      t.text :event_instructions
      t.datetime :event_start_time
      t.datetime :event_end_time
      t.integer :event_capacity

      t.timestamps
    end
  end
end