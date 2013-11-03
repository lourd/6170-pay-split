class Purchase < ActiveRecord::Base
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
		unless self.amount > 0
			self.errors.add(:amount, 'must be positive')
		end
	end

	def validate_event_not_closed
		unless self.event and self.event.closed == false
			self.errors.add(:event, 'must not be closed to add payment!')
		end
	end
end
