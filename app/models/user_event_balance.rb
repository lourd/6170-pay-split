class UserEventBalance < ActiveRecord::Base
	belongs_to :user
	belongs_to :event

	def determine_new_debt
		@event = self.event
		@user = self.user
		# Todo: Break into helper methods in User and Event
		# All the purchases for event/number people - what you've paid - your share of what you owe of your purchase
		
		total_event_purchases_share = (@event.purchases.sum('amount') / @event.users.count).round(2)
		
		event_payments_already_made = 0
		if !@user.payments.find_all_by_event_id(@event).nil?
			@user.payments.find_all_by_event_id(@event).each do |payment|
				event_payments_already_made += payment.amount
			end
		end
		#total number of purchases user made for the event
		total_user_event_purchase = 0
		if !@user.purchases.find_all_by_event_id(@event).nil?
			@user.purchases.find_all_by_event_id(@event).each do |purchase|
				total_user_event_purchase += purchase.amount
			end
		end
		share_covered_by_own_purchases = (total_user_event_purchase/@event.users.count).round(2)
		#Total debt: amount user owes to event
		total_event_purchases_share - event_payments_already_made - share_covered_by_own_purchases
	end

	def determine_new_credit_after_purchase
		@event = self.event
		@user = self.user
		num_users = @event.users.count

		total_user_event_purchase = 0
		if !@user.purchases.find_all_by_event_id(@event).nil?
			@user.purchases.find_all_by_event_id(@event).each do |purchase|
				total_user_event_purchase += purchase.amount
			end
		end
		# What is owed to the user
		(((num_users - 1)*total_user_event_purchase) / num_users).round(2)
	end

	def determine_new_credit_after_payment(sender_id, payment)
		beginning_credit = self.credit
		new_credit = 0

		# Check if a user should receive the money just paid - goes to user with highest amount of money
		# owed to them
		if @event.user_event_balances.order("credit DESC").first.user == @user && @event.user_event_balances.order("credit DESC").first.credit > 0
			@user.payment_splits.create(:amount => payment, :receiver => @user, :user_id => sender_id)
			new_credit = beginning_credit - BigDecimal(payment)
		else
			new_credit = beginning_credit
		end
		new_credit
	end

	def update_debt
		self.update_attribute(:debt, determine_new_debt)
	end

	def update_credit_after_purchase
		self.update_attribute(:credit, determine_new_credit_after_purchase)
	end

	def update_credit_after_payment(sender_id, payment)
		self.update_attribute(:credit, determine_new_credit_after_payment(sender_id, payment))
	end

end
