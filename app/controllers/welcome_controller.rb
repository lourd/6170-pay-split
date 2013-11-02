class WelcomeController < ApplicationController

  skip_before_action :require_login, :only => [:landing]

  def landing
  end
end
