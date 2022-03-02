SlackRubyBotServer::Events.configure do |config|
  config.signing_secret ||= ENV.fetch('SLACK_SIGNING_SECRET')
end
