require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "username and email are required and unique" do
    assert_not User.create.valid?
    assert_not User.create(username: 'buz').valid?
    assert_not User.create(username: 'buz', email: 'baz').valid?
    assert User.create(username: 'buz', email: 'buz@baz.com').valid?
    # binding.pry
    assert_not User.create(username: 'baz', email: 'buz@baz.com').valid?
    assert_not User.create(username: 'buz', email: 'baz@buz.com').valid?
  end
end
