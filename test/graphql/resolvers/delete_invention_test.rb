#NOTE: had a problem with tests due to missing constant Resolvers
# see: config/initializers/autoloaded_constants_patch.rb

require 'test_helper'

class Resolvers::DeleteInventionTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::DeleteInvention.new.call(nil, args, {})
  end

  test 'deleting invention' do
    assert_equal 6, Invention.count
    invention = perform(id: inventions(:one).id)
    assert_equal 5, Invention.count
    invention = perform(id: inventions(:two).id)
    assert_equal 4, Invention.count
    invention = perform(id: inventions(:three).id)
    assert_equal 3, Invention.count
    assert_equal ['one material', 'two materials', '3M'], Invention.all.map{ |x| x.title }

    # invention must exist
    assert_raises(GraphQL::ExecutionError) do
      perform(id: 1000000)
    end
  end
end
