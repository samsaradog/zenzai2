require './lib/presenters/jewel_presenter'

class PagesController < ApplicationController
  def home
    @jewel_presenter = Zenzai::JewelPresenter.new(Jewel.all.sample)
  end

  %w(about support zenzai).each do |name|
    define_method(name.to_sym) {}
  end
end
