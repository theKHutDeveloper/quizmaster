# Add role to user, defaulting to subscriber
class AddRoleToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :string, default: 'subscriber'
  end
end
