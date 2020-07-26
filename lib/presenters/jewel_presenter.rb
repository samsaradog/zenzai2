module Zenzai
  class JewelPresenter
    def initialize(jewel)
      @jewel = jewel
    end

    %i[id source citation quote comment].each do |field|
      define_method(field) do
        @jewel.send(field)
      end
    end

    %w[citation quote comment].each do |name|
      define_method("trim_#{name}".to_sym) do |length|
        trim_string(@jewel.send(name.to_sym), length)
      end
    end

    def html_quote
      @jewel.quote.gsub("\u2028", "<br>").html_safe
    end

    private

    def trim_string(string, length)
      string.slice(0, length)
    end

    attr_accessor :jewel
  end
end
