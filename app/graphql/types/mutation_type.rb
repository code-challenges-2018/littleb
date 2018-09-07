Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createInvention, function: Resolvers::CreateInvention.new
  field :updateInvention, function: Resolvers::UpdateInvention.new
  field :deleteInvention, function: Resolvers::DeleteInvention.new
  field :createMaterial, function: Resolvers::CreateMaterial.new
  field :createUser, function: Resolvers::CreateUser.new
end
