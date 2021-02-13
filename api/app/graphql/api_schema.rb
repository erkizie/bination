class ApiSchema < GraphQL::Schema
  max_depth 15 #Prevent deeply-nested queries and min is 13 if you want to run the introspection query

  mutation(RootMutation)
  query(RootQuery)

  # enable batch loading
  use BatchLoader::GraphQL
end
