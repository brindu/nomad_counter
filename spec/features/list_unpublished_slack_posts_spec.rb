require 'rails_helper'

describe 'index of unpublished slack posts', type: :feature do
  let!(:unpublished_posts) { create_list(:slack_post, 3, :unpublished) }
  let!(:published_posts) { create_list(:slack_post, 3, :published) }

  before do
    visit(unpublished_slack_posts_path)
  end

  it 'displays unpublished posts' do
    unpublished_posts.each { |post| expect(page).to have_content(post.text) }
  end

  it 'does not display already published posts' do
    published_posts.each { |post| expect(page).not_to have_content(post.text) }
  end
end
