require 'rails_helper'

describe SlackEvent::CreateNewPost do
  subject { described_class.call(event: event) }

  context 'when incoming event is a message' do
    let(:ts) { Time.zone.now }
    let(:slack_post) { SlackPost.first }

    let(:event) do
      {
        'team_id' => 'T032U7M6ZGT',
        'event' => {
          'type' => 'message',
          'user' => 'U032U764VTL',
          'text' => 'yo lol',
          'channel' => 'C032DJSD355',
          'ts' => ts.to_f
        },
        'event_id' => 'EvFGTNRKLG',
      }
    end

    it { is_expected.to be_a_success }

    it 'saves the new slack post' do
      subject

      expect(slack_post).to have_attributes({
        external_id: 'EvFGTNRKLG',
        team_id: 'T032U7M6ZGT',
        user_id: 'U032U764VTL',
        channel_id: 'C032DJSD355',
        text: 'yo lol',
        exposed: false,
      })
    end

    it 'sets the message timestamp' do
      subject

      expect(slack_post.timestamp.to_s).to eq(ts.to_s)
    end

    it 'sets the exposed? post attribute to false' do
      subject

      expect(slack_post.exposed).to eq(false)
    end
  end

  context 'when incoming event is not a message' do
    let(:event) do
      {
        'team_id' => 'T032U7M6ZGT',
        'event' => {
          'type' => 'not_a_message',
          'user' => 'U032U764VTL',
        },
        'event_id' => 'EvFGTNRKLG',
      }
    end

    it { is_expected.to be_a_success }

    it 'does not save anything in the database' do
      expect { subject }.not_to change(SlackPost, :count)
    end
  end
end
