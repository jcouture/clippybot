module ClippyBot
  class Mailer
    def self.send(from:, subject:, to:, body:)
      from_email = SendGrid::Email.new(email: from)
      to_email = SendGrid::Email.new(email: to)
      content = SendGrid::Content.new(type: 'text/plain', value: body)

      email = SendGrid::Mail.new(from_email, subject, to_email, content)
      sendgrid = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      sendgrid.client.mail._('send').post(request_body: email.to_json)
    end
  end
end
