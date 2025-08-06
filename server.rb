require 'sinatra'
require 'cowsay'

port = ENV.fetch("PORT", "8080")

configure do 
  set :server, :puma
  set :bind, '0.0.0.0'
  set :port, port
end

get '/' do
  content_type :text/plain
  Cowsay.say(params[:message] || "Set a message by adding ?message=<message here> to the URL", :random)
end
