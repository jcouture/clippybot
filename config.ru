$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'clippybot'

Thread.abort_on_exception = true

Thread.new do
  begin
    ClippyBot::Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run ClippyBot::Web
