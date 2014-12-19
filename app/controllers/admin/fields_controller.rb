class Admin::FieldsController < ApplicationController

  def destroy
    field = Field.find(params[:id])
    field.destroy
    flash[:success] = "Successfully removed form."
    redirect_to edit_admin_form_path(params[:form_id])  
  end

end