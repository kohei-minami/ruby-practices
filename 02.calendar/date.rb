#!/usr/bin/env ruby
require 'optparse'
require 'date'
opt = OptionParser.new
params = {}
opt.on("-y [OPTIONAL]"){ |year| params[:y] = year }
opt.on("-m [OPTIONAL]"){ |month| params[:m] = month }
opt.parse!(ARGV)

year = params[:y]&.to_i || Date.today.year
month = params[:m]&.to_i || Date.today.month

date_start = Date.new(year, month, 1)
date_end = Date.new(year, month, -1)
days_week = ["日 ", "月 ", "火 ", "水 ", "木 ", "金 ", "土 "]
youbi_start = date_start.wday

puts "#{month}月 #{year}".center(20) 
puts days_week.join
print ("   " * youbi_start) 

(date_start.day..date_end.day).each do |date|
  print "#{date}".center(3)
  if date % 7 == 7 - youbi_start || (youbi_start == 0 && date % 7 == youbi_start)
    puts "\n"
  end
end

