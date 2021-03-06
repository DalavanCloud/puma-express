path = ARGV.shift

require 'rubygems'
require 'puma'

events = Puma::Events.new STDOUT, STDERR

app, options = Rack::Builder.parse_file "config.ru"

s = Puma::Server.new app, events
s.min_threads = 0
s.max_threads = 10

s.add_unix_listener path

Signal.trap "INT" do
  s.stop
end

Signal.trap "TERM" do
  s.stop
end

s.run.join

