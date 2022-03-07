SlackRubyBotServer::Events.configure do |config|
  config.signing_secret ||= ENV.fetch('SLACK_SIGNING_SECRET')

  config.on :event, 'event_callback' do |event|
    result = SlackEvent::CreateNewPost.call(event: event)
    result.success?
  end
end
