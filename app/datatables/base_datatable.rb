class BaseDatatable < AjaxDatatablesRails::ActiveRecord
  # delegate :params, :to => :@view

  def initialize(params, klass)
    super(params)
    @klass = klass
  end

  def get_raw_records
    @klass.all
  end
end
