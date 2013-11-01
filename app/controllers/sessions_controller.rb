class SessionsController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]

	def new
	end

	def create
		user = User.authenticate(params[:email], params[:password])
		if user
			session[:user_id] = user.id
			flash[:success] = "Logged in"
			redirect_to events_path  
		else
			flash.now.alert = "Invalid email or password"
			render "new"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Logged out!"
	end
end
