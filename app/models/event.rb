class Event < ActiveRecord::Base

	has_many :user_event_balances, dependent: :destroy
	has_many :payments, dependent: :destroy
	has_many :purchases, dependent: :destroy
	has_many :users, through: :user_event_balances #TODO: Fix this. event.users doesn't work

	def self.update_total_balance(new_balance)
		self.total_balance = new_balance
	end

	def close_purchases
    	self.update_attribute(:purchase_closed, true)
  	end
end