require 'rails_helper'

RSpec.describe Core::Article::Operations::Delete do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  it 'deletes article' do
    result = Core::Article::Operations::Delete.call(params: { id: article.id })
    expect(result.success?).to be_truthy
  end

  it 'returns an error if article is not provided' do
    result = Core::Article::Operations::Delete.call(params: { id: article.id + 1 })
    expect(result.success?).to be_falsey
    expect(result[:errors][:article]).to include("Article not found.")
  end
end
