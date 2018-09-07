#NOTE: had a problem with tests due to missing constant Resolvers
# see: config/initializers/autoloaded_constants_patch.rb

require 'test_helper'

class Resolvers::CreateInventionTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::CreateInvention.new.call(nil, args, {})
  end

  test 'creating new invention' do
    invention = perform(
      title: 'my-title',
      description: 'my-description',
      bits_list: "bargraph, light-sensor",
      materials_list: "tape, construction-paper",
    )

    assert invention.persisted?
    assert_equal 'my-description', invention.description
    assert_equal 'my-title', invention.title
    assert_equal 2, invention.bits.size
    assert_equal %w[bargraph light-sensor], invention.bits.map{ |x| x.name }
    assert_equal 2, invention.materials.size
    assert_equal %w[tape construction-paper], invention.materials.map{ |x| x.name }
  end

  test 'creating new invention does not add bad bits or materials' do
    invention = perform(
      title: 'my-title',
      description: 'my-description',
      bits_list: "bargraph, light-sensor, foobar",
      materials_list: "scissors, tape, foobar",
    )

    assert_equal 2, invention.bits.size
    assert_equal %w[bargraph light-sensor], invention.bits.map{ |x| x.name }
    assert_equal 2, invention.materials.size
    assert_equal %w[scissors tape], invention.materials.map{ |x| x.name }
  end

  test 'creating new invention is ok with 1 bit and no materials' do
    invention = perform(
      title: 'my-title',
      description: 'my-description',
      bits_list: "bargraph"
    )

    assert_equal 1, invention.bits.size
    assert_equal 0, invention.materials.size
  end

  test 'creating new invention with user' do
    invention = perform(
      title: 'my-title',
      description: 'my-description',
      bits_list: "bargraph",
      user_id: users(:foo).id,
    )

    assert_equal users(:foo), invention.user
  end

  test 'title must be unique' do
    # name must be unique
    assert_raises(GraphQL::ExecutionError) do
      invention = perform(
        title: inventions(:one).title,
        description: 'my-description',
        bits_list: "bargraph"
      )
    end
  end

  test 'must have at least one valid bit' do
    # name must be unique
    # binding.pry
    assert_raises(GraphQL::ExecutionError) do
      invention = perform(
        title: 'my-title',
        description: 'my-description',
      )
    end

    assert_raises(GraphQL::ExecutionError) do
      invention = perform(
        title: 'my-title2',
        description: 'my-description2',
        bits_list: 'not-a-bit'
      )
    end
  end
end
