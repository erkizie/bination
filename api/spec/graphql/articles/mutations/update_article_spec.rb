require 'rails_helper'
require_relative '../../../support/graphql_spec_helper'
include GraphQL::TestHelpers

describe 'UpdateArticle', type: :mutation do
  describe 'Update an Article' do

    let(:user) { create(:user) }
    let(:user_2) { create(:user) }
    let(:article) { create(:article, user: user) }
    let(:mutation_type) { "updateArticle" }
    let(:mutation_string) { <<-GQL
        mutation updateArticle($input: UpdateArticleInput!) {
          updateArticle(input: $input) {
            article {
                id
                title
                description
                body
                userId
            }
          }
        }
    GQL
    }

    context 'valid input for article update' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
              id: article.id,
              title: "Test title"
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

      it 'updates an article' do
        expect(gql_response.data[mutation_type]["article"]).to include("title" => "Test title", "description" => article.description, "body" => article.body, "userId" => user.id.to_s)
      end
    end

    context 'user is not author of the article' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
              id: article.id,
              description: "Test description",
              body: "Test body"
            }
          },
          context: {
            current_user: user_2
          }
        )
      end

      it 'returns an error' do
        expect(gql_response.errors[0]["message"]).to include("Only owner can update")
      end

      it "doesn't update the article object" do
        expect(gql_response.data[mutation_type]).to be_nil
      end
    end
  end
end