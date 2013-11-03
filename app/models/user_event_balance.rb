class UserEventBalance < ActiveRecord::Base
	belongs_to :user
	belongs_to :event

	# Function to determine the debt owed by a user for the event after a new purchase or payment has been made
	def determine_new_debt
		@event = self.event
		@user = self.user
		# All the purchases for event/number people - what you've paid - your share of what you owe of your purchase
		total_event_purchases_share = (@event.purchases.sum('amount') / @event.users.count).round(2)
		
		# Find the total amount of payments the user has already made to event
		event_payments_already_made = 0
		if !@user.payments.find_all_by_event_id(@event).nil?
			@user.payments.find_all_by_event_id(@event).each do |payment|
				event_payments_already_made += payment.amount
			end
		end

		# Find total number of purchases user made for the event
		total_user_event_purchase = 0
		if !@user.purchases.find_all_by_event_id(@event).nil?
			@user.purchases.find_all_by_event_id(@event).each do |purchase|
				total_user_event_purchase += purchase.amount
			end
		end
		#Find the share the user does not have to pay, because it is taken out of a purchase
		share_covered_by_own_purchases = (total_user_event_purchase/@event.users.count).round(2)
		# Total debt: amount user owes to event
		total_event_purchases_share - event_payments_already_made - share_covered_by_own_purchases
	end

	# Function to determine how much money an event owes to a person, i.e. their credit
	# Credits are gained when a user makes a purchase
	def determine_new_credit
		@event = self.event
		@user = self.user
		num_users = @event.users.count
		# Calculate the total value of the purchases the user has made for the event
		total_user_event_purchase = 0
		if !@user.purchases.find_all_by_event_id(@event).nil?
			@user.purchases.find_all_by_event_id(@event).each do |purchase|
				total_user_event_purchase += purchase.amount
			end
		end
		# Calculate share of users' purchases that other users need to pay back
		# E.g. with 3 users, if User 1 makes a purchase of $30, she is owed $20
		total_purchase_amount_owed_to_user = (((num_users - 1)*total_user_event_purchase) / num_users).round(2)
		
		# The new credit 
		new_credit = total_purchase_amount_owed_to_user - self.payment_received
		new_credit
	end

	# Function to update the debt in the db
	def update_debt
		self.update_attribute(:debt, determine_new_debt)
	end

	# Function to update the credit in the db
	def update_credit
		self.update_attribute(:credit, determine_new_credit)
	end

	# Function to update payment_received in the db
	def update_payment_received(new_payment_received)
		self.update_attribute(:payment_received, self.payment_received + new_payment_received)
	end

end
