#!/usr/bin/env ruby

#cube_max = { 'red': 12, 'green': 13, 'blue': 14 }
#filename = "data_02_1_sample.txt"
filename = "data_02_1.txt"

class Lines
  attr_reader :id, :games, :possible, :power
  def initialize(line)
    @id = line.split(':')[0].split(' ')[1].to_i
    @games = line.split(':')[1].split(';').map { |g| g.split(',') }. map { |x| x.map { |y| y.split(' ') } }.map { |w| w.map { |number, color| {color.to_sym => number.to_i} } }

    @possible   = nil
    @min_red    = nil
    @min_green  = nil
    @min_blue   = nil
    power       = nil
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

  def set_minimum
    @min_red    = 0
    @min_green  = 0
    @min_blue   = 0

    @games.each do |game|
      game.each do |value|
        if value[:red] && value[:red] > @min_red
          @min_red = value[:red]
        end
        if value[:green] && value[:green] > @min_green
          @min_green = value[:green]
        end
        if value[:blue] && value[:blue] > @min_blue
          @min_blue = value[:blue]
        end
        @power = @min_red * @min_green * @min_blue
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

data.each do |el|
  el.set_minimum
end

sum = 0
data.each do |el|
  if el.possible
    sum += el.id
  end
end
p sum

sum = 0
data.each do |el|
  sum += el.power
end
p sum

# p data.length()
#pp data
#p data[0].games.length()
#p data[0].games[0]

