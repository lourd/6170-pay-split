class Event < ActiveRecord::Base

	has_many :user_event_balances, dependent: :destroy
	has_many :payments, dependent: :destroy
	has_many :purchases, dependent: :destroy
	has_many :users, through: :user_event_balances

end
