module ClippyBot
  class Bot
    def self.run
      Slack.configure do |config|
        config.token = ENV['SLACK_API_TOKEN']
        raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
      end

      client = Slack::RealTime::Client.new
      client.on :message do |data|
        handle_message(client, data)
      end
      client.start_async
    end
    
    private

    def self.handle_message(client, data)
      # Don't respond to ephemeral messages from Slack
      return if data['is_ephemeral']

      # Don't process messages sent from our bot user
      return unless data.user && data.user != client.self.id

      # Ignore messages sent in public or private channel or multi-person direct message
      return unless is_direct_message?(data)
      
      message = data.text

      # If no message, then there's nothing to do
      return if message.nil?

      send_email(client, data, message.strip)

      # Echo back messages sent to our bot
      client.web_client.chat_postMessage(channel: data.channel, text: 'Sent!')
    end

    def self.is_direct_message?(data)
      # C, it's a public channel
      # D, it's a DM with the user
      # G, it's either a private channel or multi-person DM
      channel = data.channel
      
      channel.starts_with?('D')
    end

    def self.send_email(client, data, message)
      profile = client.users[data.user][:profile]
      
      first_name = profile[:first_name]
      display_name = profile[:display_name_normalized]
      from = profile[:email]
      subject = "Message from #{first_name} (#{display_name})."
      to = ENV['MAIL_TO']
      body = %(
#{message}

---
Sent from ClippyBot (https://github.com/jcouture/clippybot)
)
      
      Mailer.send(from: from, subject: subject, to: to, body: body)
    end
  end
end
