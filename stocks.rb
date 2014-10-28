require 'em-http'
require "csv"
require 'json'

col_data= []

CSV.foreach('data/WIKI_tickers.csv',:headers => true) do |row|

  col_data << row[0]

end

col_data.each do |stock|
	filename = stock.partition('/').last

	 if not File.exist?('data/' + filename + '.csv') 
		EM.run do

				query = 'https://www.quandl.com/api/v1/datasets/' + stock + '.json?auth_token=276dWhyBCrn2Za6_xVHV'

				http = EventMachine::HttpRequest.new(query).get

			   		http.errback { p 'Uh oh'; EM.stop }
			    	http.callback {

			    		response = JSON.parse(http.response)
			    		

			    		column_header = response['column_names']
			    		symbol = response['code']
			    		name = response['name']
			    		values = response['data']

			    	 
				    	CSV.open("data/#{symbol}.csv", "wb") do |csv|		
				    		
				    		values.each do |value|
								csv << value
							end
						end
						puts symbol + " added successfully"

					


		         EventMachine.stop
		       }
		end
	end
end	