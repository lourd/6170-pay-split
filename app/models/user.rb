class User < ActiveRecord::Base
	has_many :user_event_balances
	has_many :purchases
	has_many :payments
	has_many :events, through: :user_event_balances
	has_many :payment_splits

	before_save :encrypt_password
	attr_accessor :password
	attr_accessor :password_confirmation
	
	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :password, :presence => true
	validates :password_confirmation, :presence => true, :on => :create
	validates :email, :presence => true, :uniqueness => true
	validates_with UserValidator, :on => :create

	def self.authenticate(email, password)
		user = find_by_email(email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end
