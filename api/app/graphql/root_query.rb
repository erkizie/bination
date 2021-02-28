class RootQuery < Lib::BaseObject
  field :articles, resolver: ::Articles::Resolvers::ListArticles, description: 'Articles'
end
