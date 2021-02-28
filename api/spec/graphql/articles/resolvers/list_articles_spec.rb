require 'rails_helper'
require_relative '../../../support/graphql_spec_helper'
include GraphQL::TestHelpers

describe 'Articles', type: :query do
  describe 'List all articles' do

    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }
    let(:article_2) { create(:article, user: user) }
    let(:query_type) { "articles" }
    let(:query_string) { <<-GQL
        query articles {
          articles {
              id
              title
              description
              body
              userId
          }
        }
    GQL
    }

    context 'user signed in to see the articles' do

      before do
        article
        article_2

        mutation(
          query_string,
          context: {
            current_user: user
          }
        )
      end

      it 'returns no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'returns list of the articles' do
        expect(gql_response.data[query_type].count).to eq 2
        expect(gql_response.data[query_type][0]["id"]).to eq article.id.to_s
        expect(gql_response.data[query_type][1]["id"]).to eq article_2.id.to_s
      end
    end

    context 'user is not signed in' do

      before do
        mutation(
          query_string
        )
      end

      it 'returns an error' do
        expect(gql_response.errors[0]["message"]).to include("User not signed in")
      end
    end
  end
end