class ChangeSportIdAndHostIdToBigintInPlayEvents < ActiveRecord::Migration[8.0]
  def change
    change_column :play_events, :sport_id, :bigint
    change_column :play_events, :host_id, :bigint
  end
end