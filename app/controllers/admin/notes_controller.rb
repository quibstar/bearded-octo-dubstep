class Admin::NotesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :note_params, :only => :create
  load_and_authorize_resource
  layout 'admin/admin'

  def index
    @note = Note.order(:id)
    @title = "Notes"
  end
  
  def new
    @note = Note.new
  end
  
  def create 
    if @note.save 
      flash[:success]= "Note has been created."
      redirect_to admin_notes_path
    else
      @title = "New Note"
      render :action => :new 
    end
  end
  
  def edit
    @note = Note.find(params[:id])
    @title = "Update Note"
  end
  
  def update
    if @note.update_attributes(note_params)
      flash[:success]= "Successfully updated note."
      redirect_to admin_notes_path()
      else
        render :action => 'edit'
        @title = "Edit Note"
      end
  end
  
  def destroy
      @note.destroy
      flash[:success] = "Successfully removed note."
      redirect_to admin_notes_path
  end

  def note_params
    params.require(:note).permit!
  end
end
