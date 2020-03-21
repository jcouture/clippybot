module ClippyBot
  class Web < Sinatra::Base
    get '/' do
      'Hi! I am ClippyBot, your office assistant. Would you like some assistance today?'
    end
  end
end
