class Admin::FieldOptionsController < ApplicationController
	
	before_filter :authenticate_user!

	def destroy 
		@field_options = FieldOption.find(params[:id])
    @field_options.destroy
    respond_to do |format|
      format.js
    end
	end

end