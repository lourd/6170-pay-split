class UserValidator < ActiveModel::Validator
	def validate(record)
		unless record.first_name =~ /\A\p{Alnum}+\z/
			record.errors.add(:user_name, "must be alphanumeric!")
		end

		unless record.last_name =~ /\A\p{Alnum}+\z/
			record.errors.add(:user_name, "must be alphanumeric!")
		end

		unless record.password == record.password_confirmation
			record.errors.add(:password_confirmation, "must match!")
		end
	end
end
