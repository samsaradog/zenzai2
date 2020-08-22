require './lib/presenters/jewel_presenter'
require './app/datatables/base_datatable'

class JewelsDatatable < BaseDatatable
  delegate :link_to, :edit_jewel_path, to: :@view

  def initialize(params, opts)
    super(params, Jewel)
    @view = opts[:view_context]
  end

  def view_columns
    @view_columns ||= {
      origin:   { source: "Jewel.source" },
      citation: { source: "Jewel.citation" },
      quote:    { source: "Jewel.quote" },
      comment:  { source: "Jewel.comment" },
      actions:  { source: "action" },
    }
  end

  def data
    records.map do |jewel|
      presenter = Zenzai::JewelPresenter.new(jewel)
      {
        origin:   presenter.source,
        citation: presenter.trim_citation(20),
        quote:    presenter.trim_quote(20),
        comment:  presenter.trim_comment(20),
        action:   link_to("Edit", edit_jewel_path(jewel)),
      }
    end
  end
end
