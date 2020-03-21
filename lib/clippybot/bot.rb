require 'pp'

module ClippyBot
  class Bot
    def self.run
      Slack.configure do |config|
        config.token = ENV['SLACK_API_TOKEN']
        raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
      end

      client = Slack::RealTime::Client.new
      client.on :message do |data|
        # Don't respond to ephemeral messages from Slack
        next if data['is_ephemeral']

        # Don't process messages sent from our bot user
        next unless data.user && data.user != client.self.id

        # C, it's a public channel
        # D, it's a DM with the user
        # G, it's either a private channel or multi-person DM
        channel = data.channel
        # Ignore messages sent in public or private channel or multi-person direct message
        next unless channel.starts_with?('D')
        
        message = data.text

        # If no message, then there's nothing to do
        next if message.nil?

        message = message.strip

        # Echo back messages sent to our bot
        client.web_client.chat_postMessage channel: data.channel, text: message
      end
      client.start_async
    end
  end
end
