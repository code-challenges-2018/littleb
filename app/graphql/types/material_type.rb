Types::MaterialType = GraphQL::ObjectType.define do
  name 'Material'

  field :id, !types.ID
  field :name, !types.String
end
