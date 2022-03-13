class SlackEvent::CreateNewPost < ApplicationInteractor
  def call
    SlackPost.create(new_post_attributes) if new_message?
  end

  private

  def new_post_attributes
    {
      external_id: data['event_id'],
      team_id: data['team_id'],
      user_id: data['event']['user'],
      channel_id: data['event']['channel'],
      timestamp: timestamp_to_datetime,
      text: data['event']['text'],
      discarded: false,
    }
  end

  def data
    context.event
  end

  def timestamp_to_datetime
    ts = data['event']['ts']
    Time.zone.at(ts.to_f)
  end

  def new_message?
    data['event'] && data['event']['type'] == 'message'
  end
end
