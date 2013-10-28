class Purchase < ActiveRecord::Base
	belongs_to :user
	belongs_to :event

	validates :description, :presence => true
	validates :amount, :presence => true

	validate :validate_event_selection
	validate :validate_amount

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
end
