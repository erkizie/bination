require 'rails_helper'

RSpec.describe Core::User::Operations::SignIn do
  let(:user) { create(:user) }
  let(:params) {
    { username: user.username, password: user.password }
  }

  it 'logins user and returns jwt token' do
    result = Core::User::Operations::SignIn.(params)
    expect(result.success?).to be_truthy
    expect { JWT.decode(result[:token], nil, false) }.to_not raise_error(JWT::DecodeError)
  end

  it 'raises an error when provided email instead of the username' do
    params.delete(:username)
    params[:email] = user.email
    result = Core::User::Operations::SignIn.(params)
    expect(result.success?).to be_falsey
    expect(result[:errors][:user]).to include("User not found.")
  end

  it 'raises an error when provided not correct password' do
    params[:password] = 'wrongPassword'
    result = Core::User::Operations::SignIn.(params)
    expect(result.success?).to be_falsey
    expect(result[:errors][:user]).to include("Invalid password")
  end
end
