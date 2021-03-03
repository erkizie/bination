require 'rails_helper'
require_relative '../../../support/graphql_spec_helper'
include GraphQL::TestHelpers

describe 'DeleteArticle', type: :mutation do
  describe 'Delete an Article' do

    let(:user) { create(:user) }
    let(:user_2) { create(:user) }
    let(:article) { create(:article, user: user) }
    let(:mutation_type) { "deleteArticle" }
    let(:mutation_string) { <<-GQL
        mutation deleteArticle($input: DeleteArticleInput!) {
          deleteArticle(input: $input) {
            article {
                title
                description
                body
                userId
            }
          }
        }
    GQL
    }

    context 'valid input for article deletion' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
              id: article.id
            }
          },
          context: {
            current_user: user
          }
        )
      end

      it 'returns no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'deletes an article' do
        expect(Article.all).to be_empty
      end
    end

    context 'user is not an author' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
              id: article.id
            }
          },
          context: {
            current_user: user_2
          }
        )
      end

      it 'returns an error' do
        expect(gql_response.errors[0]["message"]).to include("Only owner can delete")
      end

      it "doesn't delete an article" do
        expect(Article.all.count).to eq(1)
      end
    end
  end
end