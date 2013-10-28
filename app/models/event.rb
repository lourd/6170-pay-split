class Event < ActiveRecord::Base

	belongs_to :organizer, :class_name => "User", :foreign_key 	=> 'organizer'
	has_many :user_event_balances, dependent: :destroy
	has_many :payments, dependent: :destroy
	has_many :purchases, dependent: :destroy
	has_many :users, through: :user_event_balances

	def update_total_balance
		self.update_attribute(:total_balance, self.purchases.sum('amount'))
	end

	def close_purchases
    	self.update_attribute(:purchase_closed, true)
  	end

  	def find_user_event_balance(user_id)
  		self.user_event_balances.find_by_user_id(user_id)
  	end
end