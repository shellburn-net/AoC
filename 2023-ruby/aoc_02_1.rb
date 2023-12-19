#!/usr/bin/env ruby

#cube_max = { 'red': 12, 'green': 13, 'blue': 14 }
#filename = "data_02_1_sample.txt"
filename = "data_02_1.txt"

class Lines
  attr_reader :id, :games, :possible
  def initialize(line)
    @possible = nil
    @id = line.split(':')[0].split(' ')[1].to_i
    @games = line.split(':')[1].split(';').map { |g| g.split(',') }. map { |x| x.map { |y| y.split(' ') } }.map { |w| w.map { |number, color| {color.to_sym => number.to_i} } }
  end

  def check_possibility
    @possible= true
    @games.each do |game|
      #p "game: #{game}"
      game.each do |value|
        #p value
        if value[:red] && value[:red] > 12
          @possible = false
        end
        if value[:green] && value[:green] > 13
          @possible = false
        end
        if value[:blue] && value[:blue] > 14
          @possible = false
        end
      end
    end
  end

end

data=[]

File.foreach(filename).with_index do |line, line_num|
  line.gsub!(/\r?\n/, '') || line
  data << Lines.new(line)
end

data.each do |el|
  el.check_possibility
end

sum = 0
data.each do |el|
  if el.possible
    sum += el.id
  end
end
p sum

#p data.length()
#pp data
#p data[0].games.length()
#p data[0].games[0]

