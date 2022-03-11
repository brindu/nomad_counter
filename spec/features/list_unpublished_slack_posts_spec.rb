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

  it 'does not display discarded posts' do
    discarded_posts.each { |post| expect(page).not_to have_content(post.text) }
  end

  describe 'discard slack post' do
    let(:post) { remaining_posts.shuffle.first }

    subject(:discard!) do
      within("#slack_post_#{post.id}") do
        click_button('discard')
      end
    end

    it 'discard the slack post' do
      discard!

      expect(post.reload.discarded?).to eq(true)
    end

    it 'stays on the remaning slack posts list' do
      discard!

      expect(page).to have_current_path(slack_posts_path)
    end
  end
end
