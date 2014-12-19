class Admin::AssetsController < ApplicationController
	
	before_filter :authenticate_user!
	load_and_authorize_resource
	
	layout 'admin/admin'
	
	def index  
	
	end
  def show
    
  end
  
end
