class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :login_required, :logout_required

  private
  
  def login_required
    redirect_to new_session_path, notice: User.human_attribute_name(:login_required) unless current_user
  end

  def logout_required
    redirect_to tasks_path, notice: User.human_attribute_name(:logout_required) if current_user
  end
end
