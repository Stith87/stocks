require "csv"
require 'pathname'


$data = []

Pathname("./data/").each_child do |file|

  $data.push(file.to_s)
end

puts $data

$data.each do |stock|  
	CSV.read('"' + stock +'"',{headers:           true,
                  converters:        :numeric}) do |row|
	  puts row.inspect
	end
end