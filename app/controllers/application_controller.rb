class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	helper :all

	before_action :require_login

	private

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def require_login
		unless current_user
			redirect_to landing_page_path
		end
	end

	def get_users_in_event(event)
	    ret = Array.new
	    event.users.each do |user|
	     	ret << user.id
	    end
	    return ret
  	end

  	helper_method :get_users_in_event

	helper_method :current_user


	#unless Rails.application.config.consider_all_requests_local
		rescue_from Exception, with: lambda { |exception| render_error 500, exception }
		rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
	#end

	private
	def render_error(status, exception)
	respond_to do |format|
	  format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
	  format.all { render nothing: true, status: status }
	end
	end
end
