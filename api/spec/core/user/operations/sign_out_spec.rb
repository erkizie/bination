require 'rails_helper'

RSpec.describe Core::User::Operations::SignOut do
  let(:user) { create(:user) }

  it 'logouts user' do
    result = Core::User::Operations::SignOut.(current_user: user)
    expect(result.success?).to be_truthy
  end

  it 'raises an error when user is not provided' do
    result = Core::User::Operations::SignOut.(current_user: nil)
    expect(result.success?).to be_falsey
    expect(result[:errors][:user]).to include("User not found.")
  end
end
