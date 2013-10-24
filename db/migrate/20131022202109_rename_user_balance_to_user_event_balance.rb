class RenameUserBalanceToUserEventBalance < ActiveRecord::Migration

	def self.up
		rename_table :user_balances, :user_event_balances
	end

	def self.down
		rename_table :user_event_balances, :user_balances
	end

end
