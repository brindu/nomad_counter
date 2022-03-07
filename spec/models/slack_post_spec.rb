require 'rails_helper'

RSpec.describe SlackPost, type: :model do
  let!(:published_posts) { create_list(:slack_post, 2, :published) }
  let!(:unpublished_posts) { create_list(:slack_post, 3, :unpublished) }

  describe '.unpublished' do
    subject { described_class.unpublished }

    it { is_expected.to contain_exactly(*unpublished_posts) }
  end

  describe '.published' do
    subject { described_class.published }

    it { is_expected.to contain_exactly(*published_posts) }
  end
end
