# frozen_string_literal: true

require 'optparse'
opt = OptionParser.new
params = {}
opt.on('-a') { |v| params[:a] = v }
opt.parse!(ARGV)
flags = params[:a] ? File::FNM_DOTMATCH : 0
files = Dir.glob('*', flags)

def column_number
  3.0
end

column = (files.count / column_number).ceil
sliced_files = files.each_slice(column).to_a
max_size = sliced_files[0].size
sliced_files.map! { |number| number.values_at(0...max_size) }
transposed_files = sliced_files.transpose

def new_line
  puts "\n"
end  

longest_file = files.max_by(&:size)
transposed_files.each do |name|
  name.each.with_index do |file, file_index|
    unless file.nil?
      print file.ljust(longest_file.size + 5)
    end
  end
  new_line
end
