require 'rails_helper'

RSpec.describe Core::Article::Operations::UserArticles do
  let(:user) { create(:user) }
  let(:user_2) { create(:user) }
  let(:user_3) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:article_2) { create(:article, user: user) }
  let(:article_3) { create(:article, user: user_2) }

  before do
    article
    article_2
    article_3
  end

  it "shows list of 1 user's articles" do
    result = ::Core::Article::Operations::UserArticles.call(user: user)
    expect(result.success?).to be_truthy
    expect(Article.all.count).to eq 3
    expect(result[:model].count).to eq 2
    expect(result[:model][0].user_id).to eq user.id
    expect(result[:model][1].user_id).to eq user.id
  end

  it "shows list of 2 user's articles" do
    result = ::Core::Article::Operations::UserArticles.call(user: user_2)
    expect(result.success?).to be_truthy
    expect(Article.all.count).to eq 3
    expect(result[:model].count).to eq 1
    expect(result[:model][0].user_id).to eq user_2.id
  end

  it "shows an empty list of articles for the 3 user" do
    result = ::Core::Article::Operations::UserArticles.call(user: user_3)
    expect(result.success?).to be_truthy
    expect(Article.all.count).to eq 3
    expect(result[:model].count).to eq 0
  end
end
