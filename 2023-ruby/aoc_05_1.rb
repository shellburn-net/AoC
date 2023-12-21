#!/usr/bin/env ruby

@filename = "data_05_1_sample.txt"
# @filename = "data_05_1.txt"

Map = Struct.new(:name, :lines, :destination, :source, :range)

@seeds = []
@seed_to_soil = []
@soil_to_fertilizer = []
@fertilizer_to_water = []
@water_to_light = []
@light_to_temperature = []
@temperature_to_humidity = []
@humidity_to_location = []

def read_data
  part = 0
  File.foreach(@filename).with_index do |line, line_num|
    line.strip!

    if line == ""
      part += 1
    elsif part == 0
      @seeds << line
    elsif part == 1
      @seed_to_soil << line
    elsif part == 2
      @soil_to_fertilizer << line
    elsif part == 3
      @fertilizer_to_water << line
    elsif part == 4
      @water_to_light << line
    elsif part == 5
      @light_to_temperature << line
    elsif part == 6
      @temperature_to_humidity << line
    elsif part == 7
      @humidity_to_location << line
    end
  end
end

read_data

@a = []

pp @seeds
# @seeds.each do |i|
#   p i
# end

pp @seed_to_soil
@a << Map.new(@seed_to_soil[0], [], [], [], [])
@seed_to_soil.drop(1).each do |i|
  @a[0].lines << i.split
end

@a <<  Map.new(@soil_to_fertilizer[0], [], [], [], [])
@soil_to_fertilizer.drop(1).each do |i|
  @a[1].lines << i.split
end

pp @fertilizer_to_water
pp @water_to_light
pp @light_to_temperature
pp @temperature_to_humidity
pp @humidity_to_location
p "----"
pp @a
