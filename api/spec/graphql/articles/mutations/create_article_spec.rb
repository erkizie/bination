require 'rails_helper'
require_relative '../../../support/graphql_spec_helper'
include GraphQL::TestHelpers

describe 'CreateArticle', type: :mutation do
  describe 'Create an Article' do

    let(:user) { create(:user) }
    let(:mutation_type) { "createArticle" }
    let(:mutation_string) { <<-GQL
        mutation createArticle($input: CreateArticleInput!) {
          createArticle(input: $input) {
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

    context 'valid input for article creation' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
              title: "Test title",
              description: "Test description",
              body: "Test body"
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

      it 'creates an article' do
        expect(gql_response.data[mutation_type]["article"]).to include("title" => "Test title", "description" => "Test description", "body" => "Test body", "userId" => user.id.to_s)
      end
    end

    context 'user is not signed in' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
              title: "Test title",
              description: "Test description",
              body: "Test body"
            }
          }
        )
      end

      it 'returns an error' do
        expect(gql_response.errors[0]["message"]).to include("User not signed in")
      end

      it "doesn't create an article" do
        expect(gql_response.data[mutation_type]).to be_nil
      end
    end
  end
end