require 'test_helper'

class QueryTest < ActiveSupport::TestCase
  def perform(query_string)
    LittlebSchema.execute(query_string).to_h
  end

  test 'testing bits query' do
    result = perform("{ bits { name } }")['data']['bits'].map{ |x| x['name'] }
    assert_equal %w[bargraph light-sensor timeout], result
    Bit.create(name: 'foobar')
    result = perform("{ bits { name } }")['data']['bits'].map{ |x| x['name'] }
    assert_equal %w[bargraph light-sensor timeout foobar], result
  end

  test 'testing materials query' do
    result = perform("{ materials { name } }")['data']['materials'].map{ |x| x['name'] }
    assert_equal %w[scissors tape construction-paper], result
    Material.create(name: 'bazbuz')
    result = perform("{ materials { name } }")['data']['materials'].map{ |x| x['name'] }
    assert_equal %w[scissors tape construction-paper bazbuz], result
  end

  test 'testing users query' do
    result = perform("{ users { username email } }")['data']['users']
    assert_equal %w[foo bar], result.map{ |x| x['username'] }
    assert_equal %w[foo@bar.com bar@foo.com], result.map{ |x| x['email'] }
  end

  test 'testing inventions query' do
    Invention.delete_all
    Invention.create(
      title: 'foo',
      description: 'bar',
      bits_list: "bargraph",
      materials_list: "tape, scissors",
      user: users(:foo),
    )
    Invention.create(
      title: 'baz',
      description: 'buz',
      bits_list: "light-sensor, timeout",
      materials_list: "construction-paper",
      user: users(:bar),
    )
    result = perform("{ inventions { title description bits{ name } materials{ name }  user{ username } } }")['data']['inventions']
    # binding.pry
    assert_equal ['foo', 'baz'], result.map{ |x| x['title'] }
    assert_equal ['bar', 'buz'], result.map{ |x| x['description'] }
    assert_equal 'bargraph', result[0]['bits'][0]['name']
    assert_equal ['light-sensor', 'timeout'], result[1]['bits'].map{ |x| x['name'] }
    assert_equal ['tape', 'scissors'], result[0]['materials'].map{ |x| x['name'] }
    assert_equal 'construction-paper', result[1]['materials'][0]['name']
    assert_equal 'foo', result[0]['user']['username']
    assert_equal 'bar', result[1]['user']['username']
  end


end
