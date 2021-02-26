require 'rails_helper'
require_relative '../../../support/graphql_spec_helper'
include GraphQL::TestHelpers

describe 'SignIn', type: :mutation do
  describe 'Sign in User' do

    let(:user) { create(:user) }
    let(:mutation_type) { "signIn" }
    let(:mutation_string) { <<-GQL
        mutation signIn($input: SignInInput!){
         signIn(input: $input) {
            token
            user {
              id
              username
              email
            }
          }
        }
    GQL
    }

    context 'valid credentials for user login' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
              username: user.username,
              password: user.password
            }
          }
        )
      end

      it 'return no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'returns the user object' do
        expect(gql_response.data[mutation_type]["user"]).to include("username" => user.username, "email" => user.email)
      end
    end

    context 'invalid credentials for user login' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
              username: user.username,
              password: "password"
            }
          }
        )
      end

      it 'returns an error' do
        expect(gql_response.errors[0]["message"]).to include("Invalid password")
      end

      it "doesn't return the object" do
        expect(gql_response.data[mutation_type]).to be_nil
      end
    end
  end
end