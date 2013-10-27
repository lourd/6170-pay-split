class Purchase < ActiveRecord::Base
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
		if self.amount == 0
			self.errors.add(:amount, 'must not be 0.')
		end
	end
end
