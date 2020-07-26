require 'presenters/jewel_presenter'
require 'datatables/jewels_datatable'
require 'will_paginate'

require 'admin_controller'

class JewelsController < AdminController
  def index
    respond_to do |format|
      format.html
      format.json { render :json => Zenzai::JewelsDatatable.new(params, view_context: view_context) }
    end
  end

  def edit
    @jewel = Jewel.find(params[:id])
  end

  def update
    @jewel = Jewel.find(params[:id])
    if @jewel.update_attributes(jewel_params)
      flash[:notice] = "Successful Update"
      redirect_to jewels_path
    else
      flash[:notice] = "Update did not succeed"
      redirect_to edit_jewel_path(params[:id])
    end
  end

  private

  def jewel_params
    params.require(:jewel).permit(:source, :citation, :quote, :comment)
  end
end
