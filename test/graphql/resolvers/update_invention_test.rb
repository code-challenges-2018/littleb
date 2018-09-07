#NOTE: had a problem with tests due to missing constant Resolvers
# see: config/initializers/autoloaded_constants_patch.rb

require 'test_helper'

class Resolvers::UpdateInventionTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::UpdateInvention.new.call(nil, args, {})
  end

  test 'updating existing invention' do
    invention = perform(
      id: inventions(:one).id,
      title: 'my-title',
      description: 'this is my new description',
      bits_list: "light-sensor, timeout",
      materials_list: "scissors, tape",
      user_id: users(:foo).id,
    )
    # binding.pry

    assert invention.persisted?
    assert_equal 'my-title', invention.title
    assert_equal 'this is my new description', invention.description
    assert_equal %w[light-sensor timeout], invention.bits.map{ |x| x.name }
    assert_equal %w[scissors tape], invention.materials.map{ |x| x.name }
    assert_equal users(:foo).username, invention.user.username
  end

  test 'updating existing invention with title only' do
    invention = perform(
      id: inventions(:one).id,
      title: 'my-title',
    )
    # binding.pry

    assert invention.persisted?
    assert_equal 'my-title', invention.title
    assert_equal inventions(:one).description, invention.description
    assert_equal inventions(:one).bits, invention.bits
    assert_equal inventions(:one).materials, invention.materials
  end

  test 'updating existing invention with bits and materials' do
    invention = perform(
      id: inventions(:one).id,
      bits_list: "bargraph, timeout",
      materials_list: "tape",
    )
    # binding.pry

    assert invention.persisted?
    assert_equal inventions(:one).title, invention.title
    assert_equal inventions(:one).description, invention.description
    assert_equal %w[bargraph timeout], invention.bits.map{ |x| x.name }
    assert_equal %w[tape], invention.materials.map{ |x| x.name }
  end

end
