class UserValidator < ActiveModel::Validator
	def validate(record)
		# validate first and last name are alphanumeric
		unless record.first_name =~ /\A\p{Alnum}+\z/
			record.errors.add(:user_name, "must be alphanumeric!")
		end

		unless record.last_name =~ /\A\p{Alnum}+\z/
			record.errors.add(:user_name, "must be alphanumeric!")
		end
		# validate password confirmation matches
		unless record.password == record.password_confirmation
			record.errors.add(:password_confirmation, "must match!")
		end
	end
end
