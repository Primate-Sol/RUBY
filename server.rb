require 'sinatra'
require 'cowsay'
require 'logger'

# Set up logging
log_file = File.new("app.log", "a+")
log_file.sync = true
logger = Logger.new(log_file)

set :server, :puma
set :bind, '0.0.0.0'
set :port, ENV.fetch("PORT", "8080")

# Log requests
before do
  logger.info("Received request: #{request.request_method} #{request.path} with params: #{params.inspect}")
end

get '/' do
  content_type :text/plain
  message = params[:message] || "Set a message by adding ?message=<message here> to the URL"
  logger.info("Responding with message: #{message}")
  
  Cowsay.say(message, :random)
end

# Log errors
error do
  logger.error("Error occurred: #{env['sinatra.error'].message}")
  "An error occurred. Please try again later."
end
