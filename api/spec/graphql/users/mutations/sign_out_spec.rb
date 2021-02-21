require 'rails_helper'
require_relative '../../../support/graphql_spec_helper'
include GraphQL::TestHelpers

describe 'SignOut', type: :mutation do
  describe 'Sign out User' do

    let(:user) { create(:user) }
    let(:mutation_type) { "signOut" }
    let(:mutation_string) { <<-GQL
        mutation signOut($input: SignOutInput!){
          signOut(input: $input) {
            result
          }
        }
    GQL
    }

    context 'user is signed in' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
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

      it 'has successful result' do
        expect(gql_response.data[mutation_type]["result"]).to be_truthy
      end
    end

    context 'user is not signed in' do

      before do
        mutation(
          mutation_string,
          variables: {
            input: {
            }
          }
        )
      end

      it 'returns an errors' do
        expect(gql_response.errors[0]["message"]).to include("User not signed in")
      end

      it "doesn't return the object" do
        expect(gql_response.data[mutation_type]).to be_nil
      end
    end
  end
end