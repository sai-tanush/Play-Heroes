class AddProfileFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :location, :string
    add_column :users, :profile_picture, :string
    add_column :users, :sports, :jsonb
  end
end
