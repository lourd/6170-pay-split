class Payment < ActiveRecord::Base

	belongs_to :user
	belongs_to :event

	validates :description, :presence => true
	validates :amount, :presence => true

	validate :validate_event_selection
	validate :validate_amount

	def validate_event_selection
		unless self.event
			self.errors.add(:event, 'must be chosen.')
		end
	end

	def validate_amount
		unless self.amount and self.amount > 0 and self.amount == self.event.user_event_balances.find_by_user_id(self.user.id).debt
			self.errors.add(:amount, 'The amount you pay must equal the amount you owe')
		end
	end
end
