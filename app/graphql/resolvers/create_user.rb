class Resolvers::CreateUser < GraphQL::Function
  # arguments passed as "args"
  argument :username, !types.String
  argument :email, !types.String

  # return type from the mutation
  type Types::UserType

  def call(_obj, args, _ctx)
    begin
      User.create!(
        username: args[:username],
        email: args[:email],
      )
    rescue ActiveRecord::RecordInvalid => e
      error_messages = e.record.errors.full_messages.join("\n")
      raise GraphQL::ExecutionError.new error_messages
    end
  end
end
