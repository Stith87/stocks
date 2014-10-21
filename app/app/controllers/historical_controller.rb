class HistoricalController < ApplicationController

	def connect		
	 	@historicals = Historical.find_by_sql("SELECT * FROM historical ORDER BY date DESC")
	 	@avg_price = 0

	 	@averageData = Historical.find_by_sql("SELECT * FROM historical ORDER BY date DESC limit 200");
	 	@avg_prices = 0

	 	@historicals.each do |stock| 
          	
            @avg_price += stock.close.to_f 

		end

		@averageData.each do |stock|

			@avg_prices += stock.close

		end

		

	end


end
