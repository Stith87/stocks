# Use the OAuth gem
require 'rubygems'
require 'oauth'
require 'json'

# Your key/secrets for authentication
CONSUMER_KEY        = 'GM0tpzbCD1Vy7sqTUhwlVEW9e5YuFky9guv7QmJ1'
CONSUMER_SECRET     = 'FOFGOAPzTVD2E4cHDTD53j6RXcQ6UihfG3mQhFJp'
ACCESS_TOKEN        = 'yU899eoJfGIMQxB8DjZi1XsM8leYNlUQ1N4GxamZ'
ACCESS_TOKEN_SECRET = 'VjvgI7wRH330dhdko8cpwTc3tDiV2UwjwCvtxNsh'

# Set up an OAuth Consumer
@consumer = OAuth::Consumer.new CONSUMER_KEY, CONSUMER_SECRET, { :site => 'https://api.tradeking.com' }

# Manually update the access token/secret.  Typically this would be done through an OAuth callback when 
# authenticating other users.
@access_token = OAuth::AccessToken.new(@consumer, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

# Make a request to the API endpoint and display the response
@result = @access_token.get('/v1/market/ext/quotes.json?symbols=aapl', {'Accept' => 'application/json'}).body
parsed = JSON.parse(@result)


name = parsed['response']['quotes']['quote']['name']
last = parsed['response']['quotes']['quote']['last']


puts parse[] 
puts name + " - " + '$' + last