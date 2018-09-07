Types::BitType = GraphQL::ObjectType.define do
  name 'Bit'

  field :id, !types.ID
  field :name, !types.String
end
