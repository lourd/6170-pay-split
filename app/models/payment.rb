class Payment < ActiveRecord::Base

	belongs_to :user
	belongs_to :event

	validates :description, :presence => true
	validates :amount, :presence => true

	validate :validate_event_selection
	validate :validate_amount

	# Function to make sure a payment is attached to an event
	def validate_event_selection
		unless self.event
			self.errors.add(:event, 'must be chosen.')
		end
	end

	# Function to ensure that user can only pay exactly what they owe to an event
	def validate_amount
		unless self.amount and self.amount > 0 and self.amount <= self.event.user_event_balances.find_by_user_id(self.user.id).debt
			self.errors.add(:amount, 'You can only pay at most the amount you owe!')
		end
	end

	def find_user_event_balances_with_credit_exclude_sender(sender_id)
		self.event.user_event_balances.where.not(user_id: sender_id).where('credit > 0').order("credit DESC")
	end

	def distribute_payment(sender_id, payment)
		@event = self.event
		@user = self.user
		# Convert string to BigDecimal for comparison
		payment = BigDecimal(payment)
		user_event_balances_with_credit = find_user_event_balances_with_credit_exclude_sender(sender_id)

		# Distribute payment across all user_event_balances with positive credit (i.e. people who are owed money)
		user_event_balances_with_credit.each do |ueb|
			#End when there is no more money to distribute
			if payment <=0
				break
			end
			# Give each user_event_balance the maximum amount of money from the payment
			ueb.update_payment_received([ueb.credit, payment].min)
			create_new_payment_split_record(@user, ueb.user, payment)
			payment -= [ueb.credit, payment].min
		end
	end

	# Creates a new payment split record that records distribution of payment from sender to a receiver
	def create_new_payment_split_record(sender, receiver, payment )
		sender.payment_splits.create(:user_id => sender, :receiver => receiver, :amount => payment)
	end
end
