class Purchase < ActiveRecord::Base
	MAX_PURCHASE_AMOUNT = 250

	belongs_to :user
	belongs_to :event

	validates :amount, :presence => true

	validate :validate_event_selection
	validate :validate_amount
	validate :validate_event_not_closed

	# Ensure a purchase is tied to event
	def validate_event_selection
		unless self.event
			self.errors.add(:event, 'must be chosen.')
		end
	end
	# Do not allow users to add purchases with negative amount
	def validate_amount
		unless self.amount > 0 and self.amount <= MAX_PURCHASE_AMOUNT
			self.errors.add(:amount, 'must be positive and less than 250')
		end
	end

	def validate_event_not_closed
		unless self.event and self.event.closed == false
			self.errors.add(:event, 'must not be closed to add payment!')
		end
	end
end
