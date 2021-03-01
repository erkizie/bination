class RootQuery < Lib::BaseObject
  field :articles, resolver: ::Articles::Resolvers::ListArticles, description: 'Articles'
  field :user_articles, resolver: ::Articles::Resolvers::ListUserArticles, description: 'User Articles'
end
