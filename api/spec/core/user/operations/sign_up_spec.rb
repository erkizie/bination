require 'rails_helper'
require_relative '../../../../app/concepts/core/user/operations/sign_up'

RSpec.describe Core::User::Operations::SignUp do
  let(:params) {
    {
      params: { email: 'unit@test.com', username: 'unituser1', password: 'password' }
    }
  }

  it 'creates user' do
    result = Core::User::Operations::SignUp.(params)
    expect(result.success?).to be_truthy
  end

  it 'requires email' do
    params[:params].delete(:email)
    result = Core::User::Operations::SignUp.(params)
    expect(result.success?).to be_falsey
    expect(result[:errors][:email]).to include("can't be blank")
  end

  it 'requires username' do
    params[:params].delete(:username)
    result = Core::User::Operations::SignUp.(params)
    expect(result.success?).to be_falsey
    expect(result[:errors][:username]).to include("can't be blank")
  end

  it 'requires password to be minimum 8 characters length' do
    params[:params][:password] = "passwo"
    result = Core::User::Operations::SignUp.(params)
    expect(result.success?).to be_falsey
    expect(result[:errors][:password]).to include("is too short (minimum is 8 characters)")
  end

  it 'requires unique email' do
    user = create(:user)
    params[:params][:email] = user.email
    result = Core::User::Operations::SignUp.(params)
    expect(result.success?).to be_falsey
    expect(result[:errors][:email]).to include("has already been taken")
  end

  it 'requires unique username' do
    user = create(:user)
    params[:params][:username] = user.username
    result = Core::User::Operations::SignUp.(params)
    expect(result.success?).to be_falsey
    expect(result[:errors][:username]).to include("has already been taken")
  end
end
