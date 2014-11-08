class HistoricalController < ApplicationController

	def connect		
		symbol = "AAPL"
		@data = []
		Historical.table_name = 'stock_AAPL'
	 	
	 	@stocks =Historical.find_each( batch_size: 5000) 
				
		 
	    if request.xhr?
	      render :json => @stocks
		end
	end

end
