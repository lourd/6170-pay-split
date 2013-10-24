class AddUserIdToUserEventBalances < ActiveRecord::Migration
  def change
    add_column :user_event_balances, :user_id, :integer
  end
end
