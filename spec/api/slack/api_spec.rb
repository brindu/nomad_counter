require 'rails_helper'

describe 'Slack API Events handler', type: :request do
  subject(:post_event!) { post '/api/slack/event', params: event }

  context 'without checking the signature' do
    before { allow_any_instance_of(Slack::Events::Request).to receive(:verify!) }

    context 'when a new text message has been post in Slack' do
      let(:event) do
        {
          token: 'jd0Vwuywb5ioVAg6cHt1FtZI',
          team_id: 'T032U7M6ZGT',
          api_app_id: 'A19GAJ72T',
          event: {
            client_msg_id: '2280316d-b9fe-456b-b30f-39f733d3d702',
            type: 'message',
            user: 'U032U764VTL',
            text: 'yo lol',
            channel: 'C032DJSD355',
            event_ts: '1547842100.001400',
            ts: '1646566293.383579'
          },
          type: 'event_callback',
          event_id: 'EvFGTNRKLG',
          event_time: 1646566293,
        }
      end
      let(:new_post) { SlackPost.first }

      it 'saves the message with metadata in the database' do
        post_event!

        expect(new_post).to have_attributes({
          external_id: 'EvFGTNRKLG',
          team_id: 'T032U7M6ZGT',
          user_id: 'U032U764VTL',
          channel_id: 'C032DJSD355',
          text: 'yo lol',
        })
        expect(new_post.timestamp.to_s).to eq('2022-03-06 11:31:33 UTC')
      end

      it 'saves the post as non published yet' do
        post_event!

        expect(new_post.published?).to eq(false)
      end
    end
  end
end
