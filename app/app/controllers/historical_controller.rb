class HistoricalController < ApplicationController
	require 'net/http'
	require 'csv'
	def connect		
		
		
		Historical.table_name = 'stock_AAPL'
	 	
	 	@stocks =Historical.select(:Date,:Open,:High,:Low,:Close,:Volume).last(5000)
				
		 
	    
	      render :json => @stocks
		
	end

	def show
		

	end

	def api
 			@symbol = params[:symbol]
			@uri = URI('https://www.quandl.com/api/v1/datasets/WIKI/' + @symbol + '.json?auth_token=276dWhyBCrn2Za6_xVHV&sort_order=asc')
			@response = Net::HTTP.get_response(@uri) # => String
			@data = JSON.parse(@response.body)
			@stock = @data['data']

	end

	def eps
			@symbol = params[:eps]
			@uri = URI("https://www.quandl.com/api/v1/datasets/SF1/" + @symbol + "_PE_ART.json?auth_token=276dWhyBCrn2Za6_xVHV&sort_order=dsc")
			@response = Net::HTTP.get_response(@uri)
			@eps = JSON.parse(@response.body)
			render :json => @eps['data']
	end

	def revGrowth
			@symbol = params[:revGrowth]
			@uri = URI("https://www.quandl.com/api/v1/datasets/SF1/" + @symbol + "_REVENUEGROWTH1YR_ART.json?auth_token=276dWhyBCrn2Za6_xVHV&sort_order=dsc")
			@response = Net::HTTP.get_response(@uri)
			@revGrowth = JSON.parse(@response.body)
			render :json => @revGrowth['data']
	end

	def balance
		col_data = []
		symbol = params[:balance]
		CSV.foreach('data/balancesheet.csv',:headers => true) do |row|

		  col_data << row[0]

		end

		data = []
		col_data.each do |indicator|
			@uri = URI("https://www.quandl.com/api/v1/datasets/SF1/" + symbol + "_"+ indicator + "_MRQ.json?trim_start=2014-01-01&auth_token=276dWhyBCrn2Za6_xVHV&sort_order=dsc")
			@response = Net::HTTP.get_response(@uri)
			data.push(JSON.parse(@response.body))
		end
		
		render :json => data
		
	end

	def income
		col_data = []
		symbol = params[:income]
		CSV.foreach('data/income.csv',:headers => true) do |row|

		  col_data << row[0]

		end

		data = []
		col_data.each do |indicator|
			@uri = URI("https://www.quandl.com/api/v1/datasets/SF1/" + symbol + "_"+ indicator + "_MRQ.json?trim_start=2014-01-01&auth_token=276dWhyBCrn2Za6_xVHV&sort_order=dsc")
			@response = Net::HTTP.get_response(@uri)
			data.push(JSON.parse(@response.body))
		end
		
		render :json => data
		
	end

	def cashflow
		col_data = []
		symbol = params[:cashflow]
		CSV.foreach('data/cashflow.csv',:headers => true) do |row|

		  col_data << row[0]

		end

		data = []
		col_data.each do |indicator|
			@uri = URI("https://www.quandl.com/api/v1/datasets/SF1/" + symbol + "_"+ indicator + "_MRQ.json?trim_start=2014-01-01&auth_token=276dWhyBCrn2Za6_xVHV&sort_order=dsc")
			@response = Net::HTTP.get_response(@uri)
			data.push(JSON.parse(@response.body))
		end
		
		render :json => data
		
	end

	def metrics
		col_data = []
		symbol = params[:metrics]
		CSV.foreach('data/metrics.csv',:headers => true) do |row|

		  col_data << row[0]

		end

		data = []
		col_data.each do |indicator|
			@uri = URI("https://www.quandl.com/api/v1/datasets/SF1/" + symbol + "_"+ indicator + "_ART.json?trim_start=2014-01-01&auth_token=276dWhyBCrn2Za6_xVHV&sort_order=dsc")
			@response = Net::HTTP.get_response(@uri)
			data.push(JSON.parse(@response.body))
		end
		
		render :json => data
		
	end
end
