class UsersController < ApplicationController
	skip_before_filter :require_login, only: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_url, :notice => "Signed up!"
		else
			render "new"
		end
	end

	private

	def user_params
    	params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :venmo_account)
  	end
end
