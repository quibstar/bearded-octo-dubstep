class Admin::RegistrationsController < Devise::RegistrationsController

 def new
    flash[:info] = 'Registrations are not open yet, but please check back soon'
    redirect_to root_path
  end

  def create
    flash[:info] = 'Registrations are not open yet, but please check back soon'
    redirect_to root_path
  end
  
  protected

    def after_update_path_for(resource)
      admin_users_path
    end
end