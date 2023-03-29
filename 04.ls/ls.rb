# frozen_string_literal: true

require 'optparse'
opt = OptionParser.new
params = {}
opt.on('-a [OPTIONAL]') { |files| params[:a] = Dir.glob('*', File::FNM_DOTMATCH) }
opt.parse!(ARGV)
files = params[:a] || Dir.glob('*')

column = (files.count / 3.0).ceil
sliced_files = files.each_slice(column).to_a
max_size = sliced_files[0].size
sliced_files.map! { |number| number.values_at(0...max_size) }
transposed_files = sliced_files.transpose

longest_file = files.max_by(&:size)

transposed_files.each do |name|
  name.each.with_index do |file, _file_index|
    unless file.nil?
      print file.ljust(longest_file.size + 5)
    end
  end
  puts "\n"
end
