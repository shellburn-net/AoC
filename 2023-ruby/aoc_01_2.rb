#!/usr/bin/env ruby

#filename = "data_01_2_sample.txt"
filename = "data_01_1.txt"

sum = 0;

pattern       = ['\d', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'].map { |p| Regexp.new(p) }
pattern_rev   = ['\d'].map { |p| Regexp.new(p) } + ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'].map { |p| p.reverse }.map { |p| Regexp.new(p) }
word_to_digit = { 'one' => 1, 'two' => 2, 'three' => 3, 'four' => 4, 'five' => 5, 'six' => 6, 'seven' => 7, 'eight' => 8, 'nine' => 9 }

File.foreach(filename).with_index do |line, line_num|
  line.gsub!(/\r?\n/, '') || line

  matches = line.scan(Regexp.union(pattern)).map { |word| word_to_digit[word] || word }

  matches_rev = line.reverse.scan(Regexp.union(pattern_rev)).map { |word| word.reverse }.map { |word| word_to_digit[word] || word }

  first_digit = matches.first
  last_digit  = matches_rev.first

  number = 0
  number = [first_digit, last_digit].join.to_i
  sum += number

  puts "#{line_num}: [#{number}]: #{line}"
end
puts "Answer: #{sum}"

