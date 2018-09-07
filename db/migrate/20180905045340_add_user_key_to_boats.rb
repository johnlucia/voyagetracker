class AddUserKeyToBoats < ActiveRecord::Migration[5.2]
  def change
    add_column :boats, :user_key, :string
  end
end
