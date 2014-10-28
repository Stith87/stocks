require 'mysql2'
require 'csv'



client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "stocks")





loadData = client.query("LOAD DATA INFILE '/Users/mstith/Sites/stocks/stocks/data/A.csv' INTO TABLE test Fields Terminated by ',' ENCLOSED BY ' '  (@Date,Open,High,Low,Close,Volume,ExDividend,Split_Ratio,Adj_Open,Adj_High,Adj_Low,Adj_Close,Adj_Volume) set Date = STR_TO_DATE(@Date, '%Y-%m-%d');")