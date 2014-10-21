
require 'em-http'
require 'em-http/middleware/oauth'
require 'em-http/middleware/json_response'
require 'yajl'
require 'json'

OAuthConfig = {
  :consumer_key     => 'GM0tpzbCD1Vy7sqTUhwlVEW9e5YuFky9guv7QmJ1',
  :consumer_secret  => 'FOFGOAPzTVD2E4cHDTD53j6RXcQ6UihfG3mQhFJp',
  :access_token     => 'yU899eoJfGIMQxB8DjZi1XsM8leYNlUQ1N4GxamZ',
  :access_token_secret => 'VjvgI7wRH330dhdko8cpwTc3tDiV2UwjwCvtxNsh'
}

$quotes = []

EM.run do
  conn = EventMachine::HttpRequest.new('https://stream.tradeking.com/v1/market/quotes.json?symbols=HPQ')
  conn.use EventMachine::Middleware::OAuth, OAuthConfig

  http = conn.get
  http.stream do |chunk|

    results = JSON.parse(chunk)

    File.open("stocks.json","w") do |f|
      f.print(results)
    end

    puts results['status']

    

  end


  
  http.errback do
    EM.stop
  end

  trap("INT")  { http.close; EM.stop }
  trap("TERM") { http.close; EM.stop }
end