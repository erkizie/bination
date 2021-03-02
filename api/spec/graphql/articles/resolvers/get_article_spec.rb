require 'rails_helper'
require_relative '../../../support/graphql_spec_helper'
include GraphQL::TestHelpers

describe 'Article', type: :query do
  describe 'Get an Article' do

    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }
    let(:query_type) { "article" }
    let(:query_string) { <<-GQL
        query article($id: ID!) {
          article(id: $id) {
            title
            description
            body
            userId
          }
        }
    GQL
    }

    context 'valid id to get article' do

      before do
        mutation(
          query_string,
          variables: {
            id: article.id
          },
          context: {
            current_user: user
          }
        )
      end

      it 'returns no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'shows an article' do
        expect(gql_response.data[query_type]).to include("title" => article.title, "description" => article.description, "body" => article.body, "userId" => user.id.to_s)
      end
    end

    context 'user is not signed in' do

      before do
        mutation(
          query_string,
          variables: {
            id: article.id
          }
        )
      end

      it 'returns an error' do
        expect(gql_response.errors[0]["message"]).to include("User not signed in")
      end
    end
  end
end