# frozen_string_literal: true

#require_relative "ConwayGameOfLife/version"
$mapSize = 6
$speed = 3
$saveFileName = "name.txt"

module ConwayGameOfLife

  class Error < StandardError; end

  class Session
    def game_map
      return @@game_map
    end 

    def clear()
      if Gem.win_platform?
        system 'cls'
      else
        system 'clear'
      end
    end

    def initialize
      @@game_map = Array.new($mapSize){Array.new($mapSize){0}}
      @@game_map[0][0] = 1
      @@game_map[0][1] = 1
      @@generation_number = 1
    end

    def print_map
      puts "Generation: " + @@generation_number.to_s
      for i in 0...$mapSize do
        for j in 0...$mapSize do
          if @@game_map[i][j] == 0
            print "[ ]"
          else
            print "[X]"
          end
        end
        puts     
      end
      puts
      puts
    end

    def count_neighbours(x, y)
      count = 0
      for i in -1...1 do
        for j in -1...1 do
          tx = x+i
          ty = y+j
          if tx < 0 || tx > $mapSize -1 
            tx = x
          end
          if ty < 0 || ty > $mapSize -1 
            ty = y
          end
          if @@game_map[ty][tx] == 1
            count = count + 1
          end
        end
      end
      return count
    end

    def next_generation
      @@generation_number = @@generation_number + 1
      @temp_map = Array.new($mapSize){Array.new($mapSize){0}}
      for i in 0...$mapSize do
        for j in 0...$mapSize do
          if self.count_neighbours(i,j) < 2
            @temp_map[i][j] = 0
          elsif self.count_neighbours(i,j) == 2
            @temp_map[i][j] = 1
          elsif self.count_neighbours(i,j) == 3
            @temp_map[i][j] = 1
          elsif self.count_neighbours(i,j) > 3
            @temp_map[i][j] = 0
          end
        end
      end
      return @temp_map
    end

    def copy_map(current_map,new_map)
      for i in 0...$mapSize do
        for j in 0...$mapSize do
            current_map[i][j] = new_map[i][j]
        end
      end
    end

    def start
      self.clear
      while true
        self.print_map
        @@game_map= self.next_generation
        #saveToFile
        sleep $speed
        self.clear
      end
    end

    def saveToFile(data)
      file = File.open($saveFileName,'w'); 
      file.write(data); 
      file.close 
    end

    def loadFromFile()
      begin
      file = File.open($saveFileName,'r'); 
      rescue Errno::ENOENT
        puts "Cannot open the file!"
      else
        data = file.read
        file.close 
        return data
      end
    end

    def parseSave(data)
      str = data.strip
      str = str.tr('[]','')  
      str = str.tr(',','')  
      str = str.tr(' ','')  
      for i in 0...$mapSize
        for j in 0...$mapSize
         @@game_map[j][i] = str[i*$mapSize + j].to_i
        end
        puts 
      end
    end

  end

  

  #sesja = Session.new()
  #sesja.start

require 'gosu'

class Tutorial < Gosu::Window
  def initialize
    super 1024, 768
    self.caption = "Conway Game Of Life"
    @@MainOptionsArray = ["New Game", "Load", "Exit"]
    @@pos = 0
    #@background_image = Gosu::Image.new("./Title.png", :tileable => true)
  end
  
  def update
    if (Gosu.button_down? Gosu::KB_DOWN and !@pressed) or (Gosu::button_down? Gosu::GP_UP and !@pressed)
        @@pos = @@pos + 1
        @pressed = true
    end
    if !Gosu.button_down? Gosu::KB_DOWN and @pressed
        @pressed = false
    end
  end
  
  def draw
    draw_rect(0,10*@@pos,50,25,0xffffffff,2)
    #@background_image.draw(0, 0, 0)
  end
end

Tutorial.new.show

  
  # Your code goes here...
end