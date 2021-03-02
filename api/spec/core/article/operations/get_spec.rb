require 'rails_helper'

RSpec.describe Core::Article::Operations::Get do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  it 'get article when exists' do
    result = Core::Article::Operations::Get.(params: { id: article.id })
    expect(result.success?).to be_truthy
    expect(result[:model].id).to eq article.id
  end

  it 'throws an error when article does not exist' do
    result = Core::Article::Operations::Get.(params: { id: article.id + 1 })
    expect(result[:errors][:article]).to include("Article not found.")
  end
end
