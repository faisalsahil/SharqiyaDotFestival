class DashboardController < ApplicationController
  # load_and_authorize_resource
  include AppConstants
  
  def index
    if @current_user_role == AppConstants::SUPER_ADMIN
      redirect_to users_path
    end
  end
end
