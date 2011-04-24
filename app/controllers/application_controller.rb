class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  layout 'new_layout'
  
  before_filter :prepare_for_mobile
  before_filter :instantiate_controller_and_action_names

  
  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS|Android/
    end
  end
  
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end

  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end

end
