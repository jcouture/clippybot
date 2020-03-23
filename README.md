# ClippyBot

Simple Slack bot that forwards any direct message to an email address.

## Installation

```bash
~> git clone git@github.com:jcouture/clippybot.git
~> cd clippybot
~> bundle install
```

## Environment Variables

These environment variables are required for ClippyBot to function properly.

```bash
# Slack API token for the bot
SLACK_API_TOKEN=ABC123

# Twilio Sendrid API key
SENDGRID_API_KEY=XYZ987

# Email address where the direct messages are forwarded
MAIL_TO=info@example.com
```

## Usage

```bash
~> bundle exec foreman start
```
