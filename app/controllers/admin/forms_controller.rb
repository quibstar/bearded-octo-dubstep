class Admin::FormsController < ApplicationController


	before_filter :authenticate_user!
  before_filter :form_params, :only => :create
	authorize_resource
	layout 'admin/admin'
  
  def index
    @forms = Form.all
  end 
  
  def show
    @form = Form.find(params[:id])
    @title = @form.form_name
  end
  
  def new
    @form = Form.new
    @title = "New Form"
  end
  
  def create
    @form = Form.new(form_params)
    if @form.save
      flash[:success]= "Successfully created form."
      redirect_to admin_forms_path() 
    else
      @title = "New From"
      render :action => 'new' 
    end
  end
  
  def edit
    @form = Form.find(params[:id]) 
  end
  
  def update
    @form = Form.find(params[:id])
    if @form.update_attributes(form_params)
      flash[:success] = "Successfully updated page."
      redirect_to edit_admin_form_path(@form)
    end
  end
  
  def destroy
    form = Form.find(params[:id])
    form.destroy
    flash[:success] = "Successfully removed form."
    redirect_to admin_forms_path()
    
  end

  def form_params
    params.require(:form).permit( :title, :recipient, :description, :confirmation,:horizontal, fields_attributes: [ :id, :form_id, :field_name,:field_type, :instructions,:required, field_options_attributes: [:id, :field_id, :option, :selected, :option_value] ])
  end
end
