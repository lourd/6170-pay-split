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
			redirect_to :back, :notice => "Invalid email or password"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Successfully logged out"
	end
end
