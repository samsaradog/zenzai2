require './app/datatables/users_datatable'
require 'admin_controller'

class UsersController < AdminController
  def index
    respond_to do |format|
      format.html
      format.json { render :json => UsersDatatable.new(params) }
    end
  end
end
