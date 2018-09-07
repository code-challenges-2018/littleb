class Resolvers::DeleteInvention < GraphQL::Function
  # arguments passed as "args"
  argument :id, !types.ID

  # return type from the mutation
  type Types::InventionType

  def call(_obj, args, _ctx)
    begin
      invention = Invention.find(args[:id]) # invention must exist
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError.new e.message
    end
    invention.destroy!
    invention
  end

end
