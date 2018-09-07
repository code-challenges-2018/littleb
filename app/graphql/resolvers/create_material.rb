class Resolvers::CreateMaterial < GraphQL::Function
  argument :name, !types.String

  type Types::MaterialType

  def call(_obj, args, _ctx)
    begin
      Material.create!(
        name: args[:name],
      )
    rescue ActiveRecord::RecordInvalid => e
      error_messages = e.record.errors.full_messages.join("\n")
      raise GraphQL::ExecutionError.new error_messages
    end
  end
end
