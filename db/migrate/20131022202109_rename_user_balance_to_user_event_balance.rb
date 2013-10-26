class RenameUserBalanceToUserEventBalance < ActiveRecord::Migration

	rename_table :user_balances, :user_event_balances
end
