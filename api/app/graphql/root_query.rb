class RootQuery < Lib::BaseObject
  field :article, resolver: ::Articles::Resolvers::GetArticle, description: 'Article'
  field :articles, resolver: ::Articles::Resolvers::ListArticles, description: 'Articles'
  field :user_articles, resolver: ::Articles::Resolvers::ListUserArticles, description: 'User Articles'
end
