class AddAccountKeyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_key, :string
  end
end
