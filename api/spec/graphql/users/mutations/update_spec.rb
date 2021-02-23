require 'rails_helper'
require_relative '../../../support/graphql_spec_helper'
include GraphQL::TestHelpers

describe 'SignOut', type: :request do
  describe 'Sign out User' do

    let(:user) { create(:user) }
    let(:mutation_type) { "updateUser" }
    let(:mutation_string) { <<-GQL
        mutation updateUser($input: UpdateUserInput!){
          updateUser(input: $input) {
            user {
              id
              username
              email
            }
          }
        }
    GQL
    }

    context 'valid credentials for signed in user' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
              password: "qwerty12345"
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

      it 'updates password and returns the user object' do
        expect(gql_response.data[mutation_type]["user"]).to include("username" => user.username, "email" => user.email)
      end
    end

    context 'user is not signed in' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
              password: "qwerty12345"
            }
          }
        )
      end

      it 'returns no errors' do
        expect(gql_response.errors[0]["message"]).to include("User not signed in")
      end
    end
  end
end