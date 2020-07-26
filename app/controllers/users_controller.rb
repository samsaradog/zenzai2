#require 'datatables/users_datatable'
require 'admin_controller'
#require 'will_paginate'

class UsersController < AdminController
  def index
    respond_to do |format|
      format.html
#      format.json { render :json => Zenzai::UsersDatatable.new(params) }
    end
  end
end
