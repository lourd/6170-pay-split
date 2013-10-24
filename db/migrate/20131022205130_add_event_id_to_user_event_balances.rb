class AddEventIdToUserEventBalances < ActiveRecord::Migration
  def change
    add_column :user_event_balances, :event_id, :integer
  end
end
