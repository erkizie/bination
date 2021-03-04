require 'rails_helper'

RSpec.describe Core::Article::Operations::Update do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  it 'updates article' do
    new_title = "New title"
    expect(article.title).not_to eq(new_title)
    result = Core::Article::Operations::Update.call(params: { id: article.id, title: "New title" })
    expect(result.success?).to be_truthy
    expect(result[:model].title).to eq "New title"
  end

  it 'returns an error if article is not provided' do
    result = Core::Article::Operations::Update.call(params: { body: "New body" })
    expect(result.success?).to be_falsey
    expect(result[:errors][:article]).to include("Article not found.")
  end

  it 'returns an error if title is blank' do
    result = Core::Article::Operations::Update.call(params: { id: article.id, title: "" })
    expect(result.success?).to be_falsey
    expect(result[:errors][:title]).to include("can't be blank")
  end

  it 'returns an error if description is blank' do
    result = Core::Article::Operations::Update.call(params: { id: article.id, description: "" })
    expect(result.success?).to be_falsey
    expect(result[:errors][:description]).to include("can't be blank")
  end

  it 'returns an error if body is blank' do
    result = Core::Article::Operations::Update.call(params: { id: article.id, body: "" })
    expect(result.success?).to be_falsey
    expect(result[:errors][:body]).to include("can't be blank")
  end
end
