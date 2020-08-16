require './app/datatables/base_datatable'

class UsersDatatable < BaseDatatable

  def initialize(params)
    super(params, User)
  end

  def view_columns
    @view_columns ||= {
      email:     { source: "User.email" },
      gets:      { source: "User.gets_daily_dharma" },
      confirmed: { source: "confirmed", searchable: false, orderable: false },
    }
  end

  def data
    records.map do |record|
      {
        email:     record.email,
        gets:      record.gets_daily_dharma.to_s,
        confirmed: record.confirmed_at.present?.to_s,
      }
    end
  end
end
