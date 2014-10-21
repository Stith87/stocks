require 'rubygems'
require 'oauth'

Consumer_Key	= 'GM0tpzbCD1Vy7sqTUhwlVEW9e5YuFky9guv7QmJ1'
Consumer_Secret =	'FOFGOAPzTVD2E4cHDTD53j6RXcQ6UihfG3mQhFJp'
Access_Token =	'yU899eoJfGIMQxB8DjZi1XsM8leYNlUQ1N4GxamZ'
Access_Token_Secret =	'VjvgI7wRH330dhdko8cpwTc3tDiV2UwjwCvtxNsh'

@consumer = OAuth::Consumer.new(Consumer_Key, Consumer_Secret, {:site => 'https://api.tradeking.com'})

@access_token = OAuth::AccessToken.new(@consumer, Access_Token, Access_Token_Secret)

#puts @access_token.get('/v1/accounts.json', {'Accept' => 'application/json'}).body

puts @access_token.get('/v1/market/ext/quotes.json?symbols=hpq', {'Accept' => 'application/json'}).body  