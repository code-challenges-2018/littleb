require 'test_helper'

class BitTest < ActiveSupport::TestCase
  test "name is required and unique" do
    # binding.pry
    assert_not Bit.create.valid?
    assert Bit.create(name: 'foo').valid?
    assert_not Bit.create(name: 'foo').valid?
  end
end
