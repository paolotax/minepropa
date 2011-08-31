class RegistrationsController < Devise::RegistrationsController
  private
  # Tell Devise to redirect after account update
  def after_update_path_for(resource)
    puts :protocol
    me_url(:protocol => 'http')
  end
end