require 'test_helper'

class MaterialTest < ActiveSupport::TestCase
  test "name is required and unique" do
    # binding.pry
    assert_not Material.create.valid?
    assert Material.create(name: 'foo').valid?
    assert_not Material.create(name: 'foo').valid?
  end
end
