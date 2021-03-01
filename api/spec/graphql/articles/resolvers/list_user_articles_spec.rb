require 'rails_helper'
require_relative '../../../support/graphql_spec_helper'
include GraphQL::TestHelpers

describe 'userArticles', type: :query do
  describe 'List user articles' do

    let(:user) { create(:user) }
    let(:user_2) { create(:user) }
    let(:article) { create(:article, user: user) }
    let(:article_2) { create(:article, user: user) }
    let(:article_3) { create(:article, user: user_2) }
    let(:query_type) { "userArticles" }
    let(:query_string) { <<-GQL
        query userArticles {
          userArticles {
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
        article_3

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

      it 'returns list of the articles where user is author' do
        expect(gql_response.data[query_type].count).to eq 2
        expect(gql_response.data[query_type][0]["id"]).not_to eq article_3.id.to_s
        expect(gql_response.data[query_type][1]["id"]).not_to eq article_3.id.to_s
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