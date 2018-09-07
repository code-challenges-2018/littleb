require 'test_helper'

class Resolvers::CreateMaterialTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::CreateMaterial.new.call(nil, args, {})
  end

  test 'creating new material' do
    material = perform(
      name: 'my-name',
    )

    assert material.persisted?
    assert_equal material.name, 'my-name'

    # name must be unique
    assert_raises(GraphQL::ExecutionError) do
      material = perform(
        name: 'my-name',
      )
    end
  end
end
