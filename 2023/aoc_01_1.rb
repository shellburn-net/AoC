#!/usr/bin/env ruby

#filename = "data_01_1_sample.txt"
filename = "data_01_1.txt"

sum = 0;

File.foreach(filename).with_index do |line, line_num|
  line.gsub!(/\r?\n/, '') || line
  first_digit = line.match(/\d/)[0]
  last_digit  = line.reverse.match(/\d/)[0]

  number = [first_digit, last_digit].join.to_i
  sum += number

  puts "#{line_num}: [#{first_digit}#{last_digit}][#{number}]: #{line}"
end
puts "Answer: #{sum}"
