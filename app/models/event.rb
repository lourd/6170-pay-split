class Event < ActiveRecord::Base

	has_many :user_event_balances
	has_many :payments
	has_many :purchases
	has_many :users, through: :user_event_balances

	def self.update_total_balance(new_balance)
		self.total_balance = new_balance
	end

end
