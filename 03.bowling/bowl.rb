#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |score|
  if score == 'X'
    shots << 10
    shots << 0
  else
    shots << score.to_i
  end
end

frames = []
shots.each_slice(2) do |shot|
  frames << shot
end

point = 0
frames[0..9].each_with_index do |frame, i|
  point += frame.sum
  if frames[i] == [10, 0] && frames[i + 1] == [10, 0]
    point += frames[i + 1].first
    point += frames[i + 2].first
  elsif frames[i] == [10, 0]
    point += frames[i + 1].sum
  elsif frames[i].sum == 10
    point += frames[i + 1].first
  end
end

puts point
