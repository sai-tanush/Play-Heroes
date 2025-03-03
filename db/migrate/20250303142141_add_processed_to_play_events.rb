class AddProcessedToPlayEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :play_events, :processed, :boolean, default: false
  end
end
