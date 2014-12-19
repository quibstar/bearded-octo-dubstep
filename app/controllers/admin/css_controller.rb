class Admin::CssController < ApplicationController
	
	before_filter :authenticate_user!
	
	layout 'admin/admin'

	CSS_DIR = Rails.root.join("app", "assets", "stylesheets")

	def index
		@css = File.read("#{CSS_DIR}/css.css")
		@title = "CSS"
	end

	def update
		File.open("#{CSS_DIR}/css.css", 'w') {|f| f.write(params[:css]) }
		flash[:success]= "Successfully updated css."
		redirect_to admin_css_index_path
	end
end
