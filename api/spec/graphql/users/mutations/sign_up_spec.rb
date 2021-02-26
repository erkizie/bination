require 'rails_helper'
require_relative '../../../support/graphql_spec_helper'
include GraphQL::TestHelpers

describe 'SignUp', type: :mutation do
  describe 'Creating a User' do

    let(:mutation_type) { "signUp" }
    let(:mutation_string) { <<-GQL
        mutation signUp($input: SignUpInput!){
         signUp(input: $input) {
            user {
              id
              username
              email
            }
          }
        }
    GQL
    }

    context 'valid credentials for user registration' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
              email: "postman1337@test.com",
              username: "postman1337",
              password: "password"
            }
          }
        )
      end

      it 'returns no errors' do
        expect(gql_response.errors).to be_nil
      end

      it 'returns the user object' do
        expect(gql_response.data[mutation_type]["user"]).to include("username" => "postman1337")
      end
    end

    context 'invalid credentials for user registration' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
              username: "postman1337",
              password: "password"
            }
          }
        )
      end

      it 'returns an error' do
        expect(gql_response.errors[0]["message"]).to include("Expected value to not be null")
      end

      it "doesn't return the user object" do
        expect(gql_response.data).to be_nil
      end
    end
  end
end