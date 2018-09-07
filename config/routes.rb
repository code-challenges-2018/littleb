# NOTE: can't seem to deploy app on Heroku with GraphiQL
# Rails.application.routes.draw do
#   post "/graphql", to: "graphql#execute"
#   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
# end

Rails.application.routes.draw do
  if Rails.env.development?
      mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
    end
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
