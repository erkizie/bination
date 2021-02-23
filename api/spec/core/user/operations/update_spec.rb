require 'rails_helper'

RSpec.describe Core::User::Operations::Update do
  let(:user) { create(:user) }

  it 'updates user password' do
    new_password = 'newPassword'
    expect(user.password).not_to eq(new_password)
    result = Core::User::Operations::Update.(params: { password: new_password }, current_user: user)
    expect(result.success?).to be_truthy
    expect(user.password).to eq(new_password)
  end

  it 'ignores when updating email or username' do
    new_email = "newemail@test.com"
    new_username = "newusername"
    result = Core::User::Operations::Update.(params: { email: new_email, username: new_username }, current_user: user)
    expect(result.success?).to be_truthy
    expect(user.email).not_to eq(new_email)
    expect(user.username).not_to eq(new_username)
  end

  it 'validates maximum length of password' do
    result = Core::User::Operations::Update.(params: { password: '123456' }, current_user: user)
    expect(result.success?).to be_falsey
    expect(result[:errors][:password]).to include("is too short (minimum is 8 characters)")
  end
end
