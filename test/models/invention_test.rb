require 'test_helper'

class InventionTest < ActiveSupport::TestCase
  test "title and description and at least one bit are required" do
    # binding.pry
    assert_not Invention.create.valid?
    assert_not Invention.create(title: 'foo').valid?
    assert_not Invention.create(description: 'foo').valid?
    assert_not Invention.create(title: 'foo', description: 'bar').valid?
    assert Invention.create(title: 'foo', description: 'bar', bits_list: "light-sensor").valid?
  end

  test "title is unique" do
    # binding.pry
    assert Invention.create(title: 'foo', description: 'bar', bits_list: "light-sensor").valid?
    assert_not Invention.create(title: 'foo', description: 'baz', bits_list: "light-sensor").valid?
  end

  test "can have a user" do
    assert Invention.create(title: 'foo', description: 'bar', user: users(:foo))
  end

  # is this a reasonable test, just using fixtures to prove it works?
  test "can have many bits, but must have at least one" do
    assert_equal 1, inventions(:one).bits.size
    assert_equal 2, inventions(:two).bits.size
    assert_equal 3, inventions(:three).bits.size
  end

  test "can have many materials, but none are required" do
    assert_equal 0, inventions(:one).materials.size
    assert_equal 1, inventions(:onem).materials.size
    assert_equal 2, inventions(:twom).materials.size
    assert_equal 3, inventions(:threem).materials.size
  end
end
