require 'test_helper'

class Resolvers::CreateUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::CreateUser.new.call(nil, args, {})
  end

  test 'creating new user' do
    user = perform(
      username: 'bazbuz',
      email: 'baz@buz.com'
    )

    assert user.persisted?
    assert_equal user.username, 'bazbuz'
    assert_equal user.email, 'baz@buz.com'

    # username and email must be unique
    assert_raises(GraphQL::ExecutionError) do
      user = perform(
        username: 'bazbuzzzzz',
        email: 'baz@buz.com'
      )
    end
    assert_raises(GraphQL::ExecutionError) do
      user = perform(
        username: 'bazbuz',
        email: 'buzzzzzz@buz.com'
      )
    end
  end
end
