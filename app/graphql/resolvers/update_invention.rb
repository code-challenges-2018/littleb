class Resolvers::UpdateInvention < GraphQL::Function
  argument :id, !types.ID
  argument :description, types.String
  argument :title, types.String
  argument :user_id, types.ID
  # NOTE: have not been able to get arrays working via GraphQL, so this is a bit of a hack.
  # We're taking bits as a comma separate list of names.
  # Ideally, we would solve the array in GraphQL problem.
  argument :bits_list, types.String
  argument :materials_list, types.String

  type Types::InventionType

  def call(_obj, args, _ctx)
    begin
      invention = Invention.find(args[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError.new e.message
    end
    begin
      invention.update!(args.to_h)
    rescue ActiveRecord::RecordInvalid => e
      error_messages = e.record.errors.full_messages.join("\n")
      raise GraphQL::ExecutionError.new error_messages
    end
    invention
  end

end
