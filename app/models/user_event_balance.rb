class UserEventBalance < ActiveRecord::Base
	belongs_to :user
	belongs_to :event

	# Function to determine how much has the user purchased for the event
	def total_user_event_purchases()
		event = self.event
		user = self.user

		total_user_event_purchase = 0
		if !user.purchases.find_all_by_event_id(event).nil?
			user.purchases.find_all_by_event_id(event).each do |purchase|
				total_user_event_purchase += purchase.amount
			end
		end

		total_user_event_purchase
	end

	# Function to determine how much has the user payed for the event
	def total_user_event_payments()
		event = self.event
		user = self.user

		event_payments_already_made = 0
		if !user.payments.find_all_by_event_id(event).nil?
			user.payments.find_all_by_event_id(event).each do |payment|
				event_payments_already_made += payment.amount
			end
		end

		event_payments_already_made
	end

	# Function to determine the total share of each user for the event.
	def total_event_purchases_share
		(self.event.purchases.sum('amount') / self.event.users.count).round(2)
	end

	# Function to determine the debt owed by a user for the event after a new purchase or payment has been made
	def determine_new_debt
		[self.total_event_purchases_share - self.total_user_event_payments - self.total_user_event_purchases, 0].max
	end

	# Function to determine how much money an event owes to a person, i.e. their credit
	# Credits are gained when a user makes a purchase
	def determine_new_credit
		[self.total_user_event_purchases + self.total_user_event_payments - self.total_event_purchases_share - self.payment_received, 0].max
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
		q = self.payment_received
		self.update_attribute(:payment_received, q + new_payment_received)

		self.update_credit
	end
end
