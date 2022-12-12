class Map
    def initialize(width,height)
        @map = Array.new(height){Array.new(width){0}}
        @width = width
        @height = height
    end

    def get_map()
        return @map
    end

    def set(x,y,v)
        x /= 8
        y /= 8
        @map[y][x] = v
    end

    def printer()
        for i in 0...@height do
            for j in 0...@width do
                print @map[i][j]
            end
            puts
        end
    end

    def insert(arr)
        height = arr.length
        width = arr[0].length
        if height > @height
            h = @height
        else
            h = height
        end
        if width > @width
            w = @width
        else
            w = width
        end
        for i in 0...h do
            for j in 0...w do
                @map[i][j] = arr[i][j]
            end
        end
    end
    
    def replace(arr)
        height = arr.length
        width = arr[0].length
        @map = Array.new(height){Array.new(width){0}}
        @height = height
        @width = width
        for i in 0...height do
            for j in 0...width do
                @map[i][j] = arr[i][j]
            end
        end
    end
    
    def resize(width,height)
        map_copy = @map
        width_copy = @width
        height_copy = @height
        @map = Array.new(height){Array.new(width){0}}
        self.insert(map_copy)      
    end
end