require 'rails_helper'

RSpec.describe Core::Article::Operations::Index do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:article_2) { create(:article, user: user) }
  let(:article_3) { create(:article, user: user) }

  before do
    article
    article_2
    article_3
  end

  it 'shows list of articles' do
    result = ::Core::Article::Operations::Index.call
    expect(result.success?).to be_truthy
    expect(result[:model].count).to eq 3
    expect(result[:model][0].id).to eq article.id
    expect(result[:model][1].id).to eq article_2.id
    expect(result[:model][2].id).to eq article_3.id
  end
end
