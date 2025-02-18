class CreateJoinTableUsersSports < ActiveRecord::Migration[8.0]
  def change
    create_join_table :users, :sports do |t|
      # t.index [:user_id, :sport_id]
      # t.index [:sport_id, :user_id]
    end
  end
end
