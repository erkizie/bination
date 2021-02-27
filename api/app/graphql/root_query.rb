class RootQuery < Lib::BaseObject
  field :articles, resolver: ::Articles::Resolvers::Index, description: 'Articles'
end
