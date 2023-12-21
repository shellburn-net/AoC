#!/usr/bin/env ruby

require "awesome_print"

# @filename = "data_04_1_sample.txt"
# @filename = "data_04_2_sample.txt"
@filename = "data_04_1.txt"

Card = Struct.new(:id, :nw, :ng, :found, :points, :coppies)

def read_file
  data = []
  File.foreach(@filename).with_index do |line, line_num|
    data  << line.chomp
  end
  return data
end

data = read_file
pp data

def parse_to_struct(data, array)
  data.each do |i|
    c =  Card.new
    c.id = i.split(':')[0].split(' ')[1].to_i
    c.nw = i.split(':')[1].split('|')[0].split
    c.ng = i.split(':')[1].split('|')[1].split

    array << c
  end

  return array
end

def find_winning_numbers(array)
  array.each do |c|
    i = 0
    c.nw.each do |n|
      if c.ng.include?(n)
        p "#{n} found in #{c.ng}"
        i += 1
      end
    c.found = i
    end
  end

  return array
end

def calculate_points(array)
  array.each do |c|
    c.points = 2 ** (c.found - 1)
    if c.found == 0
      c.points = 0
    end
  end
  return array
end

def set_copies(array)
  array.each do |c|
    coppies = []
    c.found.times do |i|
      p "id: #{c.id} + #{i + 1} = #{c.id + i + 1}"
      coppies << c.id + i + 1
    end
    c.coppies = coppies
  end
end

def create_copy_cards(array)
  array.each do |c|
    c.coppies.each do |id|
      # p id
      found_element = array.find { |e| e.id == id }
      array << found_element if found_element
    end
  end
  return array
end

array = []
parse_to_struct(data, array)

find_winning_numbers(array)

calculate_points(array)

array.sum(&:points)

set_copies(array)

pp array

create_copy_cards(array)

puts "final ..."
p array.map {|c| c.id }.sort.size
