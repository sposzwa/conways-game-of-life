require_relative 'map_service'
require_relative 'memory_service'

class Session
    def initialize(width,height)
        @generation_number = 1
        @game_map = Map.new(width,height)      
    end

    def next_generation()
        @generation_number += 1
        height = @game_map.get_map.length
        width = @game_map.get_map[0].length
        t_map = Array.new(height){Array.new(width){0}}
        for i in 0...height do
            for j in 0...width do
                count = self.count_neighbours(j,i)
                if count < 2
                    t_map[i][j] = 0
                elsif count == 2 && @game_map.get_map[i][j] >= 1
                    cell = @game_map.get_map[i][j]
                    case cell
                    when 1..3
                        t_map[i][j] = @game_map.get_map[i][j]+1
                    when 4
                        t_map[i][j] = @game_map.get_map[i][j]
                    end
                elsif count == 3
                    cell = @game_map.get_map[i][j]
                    case cell
                    when 0..3
                        t_map[i][j] = @game_map.get_map[i][j]+1
                    when 4
                        t_map[i][j] = @game_map.get_map[i][j]
                    end
                elsif count > 3
                    t_map[i][j] = 0
                end
            end
        end
        @game_map.replace(t_map)
    end

    def print()
        puts "GENERATION: #{@generation_number}"
        @game_map.printer
        puts
    end

    def get_cell(xCord,yCord)
        @game_map.get_map[yCord][xCord]
    end

    def set_cell(xCord,yCord)
        @game_map.set(xCord,yCord,1)
    end

    def get_generation_number()
        return @generation_number
    end

    def save_game()
        Memory.save(@game_map.get_map(),@generation_number)
    end

    def load_game()
        data = Memory.load_parsed()
        @game_map.replace(data[0])
        @generation_number = data[1].to_i
    end

    def count_neighbours(x, y)
        count = 0
        height = @game_map.get_map.length
        width = @game_map.get_map[0].length
        for i in -1..1 do
            for j in -1..1 do
                tx = x + j
                ty = y + i
                if ty < 0 || ty > height - 1
                    next
                end
                if tx < 0 || tx > width - 1
                    next
                end
                if i == 0 && j == 0
                    next
                end
                if @game_map.get_map[ty][tx] >= 1
                    count += 1
                end
            end
        end
        return count
    end
end