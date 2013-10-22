class User < ActiveRecord::Base

	has_many :user_event_balances
	has_many :purchases
	has_many :payments
	has_many :events, through: :user_event_balances
	has_many :payment_splits
end
