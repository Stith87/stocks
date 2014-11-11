require 'em-http'
require "csv"
require 'json'
require 'mysql2'


col_data= []
Mysql2::Client.default_query_options[:connect_flags] |= Mysql2::Client::MULTI_STATEMENTS
db = Mysql2::Client.new(:host => "aa1e4yvvfw7k4xp.citbgz1489ah.us-west-2.rds.amazonaws.com", :username => "stith87", :password => "Browns87", :database => "mikestit_stocks")

CSV.foreach('data/WIKI_tickers.csv',:headers => true) do |row|

  col_data << row['Indicator']

end

col_data.each do |stock|
	filename = stock.partition('/').last
	results = db.query("SELECT * FROM stock_#{filename} WHERE Date = '2014-11-07';")
	if(results.count == 0)
		EM.run do

				query = 'https://www.quandl.com/api/v1/datasets/' + stock + '.json?auth_token=276dWhyBCrn2Za6_xVHV&trim_start=2014-11-03'

				http = EventMachine::HttpRequest.new(query).get

			   		http.errback { p 'Uh oh'; EM.stop }
			   		
			    	http.callback {

			    		if (http.response_header.status == 200) then
				    		response = JSON.parse(http.response)
				    		

				    		column_header = response['column_names']
				    		symbol = response['code']
				    		name = response['name']
				    		values = response['data']
				    		q = []
				    	 
					    	CSV.open("data/#{symbol}.csv", "wb") do |csv|		
					    		
					    		values.each do |value|
									csv << value
								end
							end		
					    
					    	db.query('CREATE TABLE IF NOT EXISTS stock_'+ symbol +'(
								  Date DATE  NOT NULL PRIMARY KEY
								, Open NUMERIC(6,3)
								, High NUMERIC(7,4)
								, Low NUMERIC(7,4)
								, Close NUMERIC(5,2)
								, Volume NUMERIC(9,1)
								, ExDividend NUMERIC(4,2)
								, Split_Ratio NUMERIC(3,1)
								, Adj_Open NUMERIC(15,13)
								, Adj_High NUMERIC(15,13)
								, Adj_Low NUMERIC(15,13)
								, Adj_Close NUMERIC(15,13)
								, Adj_Volume NUMERIC(9,1)
								);')

								db.query("LOAD DATA LOCAL INFILE 'data/#{symbol}.csv'
									IGNORE INTO TABLE stock_#{symbol}
									FIELDS TERMINATED BY ','
									LINES TERMINATED BY '\n'
									(Date,Open,High,Low,Close,Volume,ExDividend,Split_Ratio,Adj_Open,Adj_High,Adj_Low,Adj_Close,Adj_Volume);")
							    
							    puts symbol + " added successfully"
						end
		         EventMachine.stop
		       }
		end
	 db.abandon_results! 
	end
end	

db.close