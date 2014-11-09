class HistoricalController < ApplicationController
	require 'net/http'
	def connect		
		
		
		Historical.table_name = 'stock_AAPL'
	 	
	 	@stocks =Historical.select(:Date,:Open,:High,:Low,:Close,:Volume).last(5000)
				
		 
	    
	      render :json => @stocks
		
	end

	def show
		

	end

	def api
 			@symbol = params[:symbol]
			query = 'https://www.quandl.com/api/v1/datasets/WIKI/' + @symbol + '.json?auth_token=276dWhyBCrn2Za6_xVHV&sort_order=asc'

			uri = URI('https://www.quandl.com/api/v1/datasets/WIKI/' + @symbol + '.json?auth_token=276dWhyBCrn2Za6_xVHV&sort_order=asc')
			response = Net::HTTP.get_response(uri) # => String
			data = JSON.parse(response.body)
			@stock = data['data']
	end
end
