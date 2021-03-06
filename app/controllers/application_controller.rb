class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper :all
  
  before_filter :prepare_for_mobile
  before_filter :instantiate_controller_and_action_names

  layout :layout_by_resource
  
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope      = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    redirect_to after_sign_in_path_for(resource)
  end
  
  def after_sign_in_path_for(resource_or_scope)
    #raise resource_or_scope.inspect
    root_url(:protocol => 'http')
  end

  # Tell Devise to redirect after sign_out
  def after_sign_out_path_for(resource_or_scope)
    #raise resource_or_scope.inspect
    root_url(:protocol => 'http')
  end
  
  def render(options = nil, extra_options = {}, &block)
    if request.headers['X-PJAX'] == 'true'
      options = {} if options.nil?
      options[:layout] = false 
    end
    super(options, extra_options, &block)
  end

  protected

    def layout_by_resource
      if devise_controller?
        "devise_layout"
      else
        "new_layout"
      end
    end

  
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
