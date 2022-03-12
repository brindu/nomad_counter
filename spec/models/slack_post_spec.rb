require 'rails_helper'

RSpec.describe SlackPost, type: :model do
  let!(:discarded_posts) { create_list(:slack_post, 2, :discarded) }
  let!(:remaining_posts) { create_list(:slack_post, 3, :remaining) }

  describe '.discarded' do
    subject { described_class.discarded }

    it { is_expected.to contain_exactly(*discarded_posts) }
  end

  describe '.remaining' do
    subject { described_class.remaining }

    it { is_expected.to contain_exactly(*remaining_posts) }

    it 'does not return posts with events' do
      posts = create_list(:slack_post, 2, :with_event)

      expect(subject).not_to include(*posts)
    end
  end
end
