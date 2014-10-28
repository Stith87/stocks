require 'em-http'
require "csv"
require 'json'
require 'date'

col_data= []
today = Date.today.to_s

CSV.foreach('data/WIKI_tickers.csv',:headers => true) do |row|

  col_data << row[0]

end

col_data.each do |stock|
	symbol = stock.slice(5..10)

	CSV.open("data/" + symbol + ".csv", "a+", :write_headers => false, :headers => true) do |csv|		
		

		dateMatch = csv.find {|row| row['Date'] == today}
		
		if dateMatch == nil

			EM.run do
					today = "2014-10-27"

					query = 'https://www.quandl.com/api/v1/datasets/' + stock + '.json?trim_start=' + today + '&auth_token=276dWhyBCrn2Za6_xVHV'

					http = EventMachine::HttpRequest.new(query).get

				   		http.errback { p 'Uh oh'; EM.stop }
				    	http.callback {

				    		response = JSON.parse(http.response)
				    		

				    		column_header = response['column_names']
				    		symbol = response['code']
				    		name = response['name']
				    		values = response['data']

				    
							CSV.open("data/#{symbol}.csv", "r+") do |csv|		
				    		
					    		values.each do |value|
									csv.add_row(value)
								end
							end

						


			         EventMachine.stop
			       }
			end

			puts symbol + " updated successfully"
		else
		    puts symbol +" skipped"
		end
		
				    		
	end	



	
end	