require 'rails_helper'

describe 'index of remaining slack posts to process', type: :feature do
  let!(:remaining_posts) { create_list(:slack_post, 3, :remaining) }
  let!(:discarded_posts) { create_list(:slack_post, 3, :discarded) }

  before do
    visit(slack_posts_path)
  end

  it 'displays remaining posts' do
    remaining_posts.each { |post| expect(page).to have_content(post.text) }
  end

  it 'does not display already discarded posts' do
    discarded_posts.each { |post| expect(page).not_to have_content(post.text) }
  end
end
