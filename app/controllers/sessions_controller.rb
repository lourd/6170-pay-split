class SessionsController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]

	def new
	end

	def create
		user = User.authenticate(params[:user_name], params[:password])
		if user
			session[:user_id] = user.id
			redirect_to root_url, :notice => "Logged in!"
		else
			flash.now.alert = "Invalid user name or password"
			render "new"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Logged out!"
	end
end
