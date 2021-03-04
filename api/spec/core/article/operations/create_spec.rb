require 'rails_helper'

RSpec.describe Core::Article::Operations::Create do
  let(:user) { create(:user) }
  let(:params) {
    {
      params: { title: "Test title", description: "Test description", body: "Test body" }
    }
  }

  it 'creates article' do
    params[:params].merge!(user_id: user.id)
    result = Core::Article::Operations::Create.call(params)
    expect(result.success?).to be_truthy
    expect(result[:model].title).to eq "Test title"
    expect(result[:model].description).to eq "Test description"
    expect(result[:model].body).to eq "Test body"
    expect(result[:model].user_id).to eq user.id
  end

  it 'returns an error when no user provided' do
    result = Core::Article::Operations::Create.call(params)
    expect(result.success?).to be_falsey
    expect(result[:errors][:user_id]).to include("can't be blank")
  end

  it 'returns an error when no title provided' do
    params[:params].delete(:title)
    result = Core::Article::Operations::Create.call(params)
    expect(result.success?).to be_falsey
    expect(result[:errors][:title]).to include("can't be blank")
  end

  it 'returns an error when no description provided' do
    params[:params].delete(:description)
    result = Core::Article::Operations::Create.call(params)
    expect(result.success?).to be_falsey
    expect(result[:errors][:description]).to include("can't be blank")
  end

  it 'returns an error when no body provided' do
    params[:params].delete(:body)
    result = Core::Article::Operations::Create.call(params)
    expect(result.success?).to be_falsey
    expect(result[:errors][:body]).to include("can't be blank")
  end
end
