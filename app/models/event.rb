class Event < ActiveRecord::Base

	belongs_to :organizer, :class_name => "User", :foreign_key 	=> 'organizer'
	has_many :user_event_balances, dependent: :destroy
	has_many :payments, dependent: :destroy
	has_many :purchases, dependent: :destroy
	has_many :users, through: :user_event_balances

	def self.update_total_balance(new_balance)
		self.total_balance = new_balance
	end

	def close_purchases
    	self.update_attribute(:purchase_closed, true)
  	end
end