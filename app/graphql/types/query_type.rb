Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :inventions, !types[Types::InventionType] do
    resolve -> (obj, args, ctx) { Invention.all }
  end

  field :users, !types[Types::UserType] do
    resolve -> (obj, args, ctx) { User.all }
  end

  # NOTE: use this to populate a dropdown for adding bits to an invention
  field :bits, !types[Types::BitType] do
    resolve -> (obj, args, ctx) { Bit.all }
  end

  # NOTE: use this to populate a dropdown for adding materials to an invention,
  # though, this will also need to have the ability to add a material.
  field :materials, !types[Types::MaterialType] do
    resolve -> (obj, args, ctx) { Material.all }
  end
end
