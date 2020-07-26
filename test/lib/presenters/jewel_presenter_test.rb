require 'test_helper'
require './lib/presenters/jewel_presenter'

class JewelPresenterTest < ActiveSupport::TestCase
  setup do
    @jewel = Jewel.create(source: 'blah',
                          citation: 'abc' * 99,
                          quote: 'def' * 99,
                          comment: 'ghi' * 99)
    @length = 20
    @presenter = ::Zenzai::JewelPresenter.new(@jewel)
  end

  %i[id source citation quote comment].each do |field|
    test "returns the #{field.to_s}" do
      assert_equal(@jewel.send(field), @presenter.send(field))
    end
  end

  %w[citation quote comment].each do |name|
    test "returns trimmed #{name}" do
      assert_equal(@presenter.send("trim_#{name}".to_sym, @length).length, @length)
    end
  end

  test "adds <br> codes for unicode eol in the quote" do
    @jewel.quote = "abc\u2028def"
    assert_equal(@presenter.html_quote, "abc<br>def")
  end
end
