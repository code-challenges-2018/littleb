Types::InventionType = GraphQL::ObjectType.define do
  name 'Invention'

  field :id, !types.ID
  field :title, !types.String
  field :description, !types.String
  field :user, -> { Types::UserType }
  field :bits, types[Types::BitType]
  field :materials, types[Types::MaterialType]
end
