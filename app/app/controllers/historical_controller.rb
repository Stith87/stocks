class HistoricalController < ApplicationController

	def connect		
		@symbol = "AAPL"
		Historical.table_name = 'stock_AAPL'
	 	@historicals = Historical.find_by_sql("SELECT * FROM stock_#{@symbol} ORDER BY date DESC")
	 	@avg_price = 0

	 	respond_to do |format|
             format.html # show.html.erb
             format.json { render json: @historicals} #  

         end 

	 	@averageData = Historical.find_by_sql("SELECT * FROM stock_#{@symbol} ORDER BY date DESC limit 200");
	 	@avg_prices = 0
	 	@stock_array = []



	 	
	 	@historicals.map do |stock| 
          	
          	stock = stock.to_json.delete! ''

            @stock_array << stock

		end



		@averageData.each do |stock|

			@avg_prices += stock.Close

		end

		

	end


end
