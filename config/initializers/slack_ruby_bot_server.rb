SlackRubyBotServer.configure do |config|
  config.oauth_version = :v2
  config.oauth_scope = ENV.fetch('SLACK_OAUTH_SCOPE').split(/\s*,\s*/)
end
