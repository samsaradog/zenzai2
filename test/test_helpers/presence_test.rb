module PresenceTest
  def assert_presence(klass, field)
    object = klass.new
    object.send("#{field}=", nil)
    object.valid?

    assert_not_empty(object.errors[field])
  end
end
