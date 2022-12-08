require_relative 'map_service'

class Memory
    $DEFAULT_SAVE_FILENAME = 'modules/save.txt'

    def self.save(arr,generation_number)
        file = File.open($DEFAULT_SAVE_FILENAME,'w'); 
        file.write(arr); 
        file.write("\n#{arr.length}")
        file.write("\n#{arr[0].length}")
        file.write("\n#{generation_number}")
        file.close 
    end

    def self.load()
        begin
        file = File.open($DEFAULT_SAVE_FILENAME,'r'); 
        rescue Errno::ENOENT
            puts "Cannot open the #{$DEFAULT_SAVE_FILENAME}!"
        else
            data = Array.new()
            IO.foreach(file){|x| data.push(x)}
            return data
        end
    end

    def self.parse_data(data)
        map_data = data[0]
        map_data = map_data.tr('[]','')  
        map_data = map_data.tr(',','')  
        map_data = map_data.tr(' ','')  
        height = data[1].to_i
        width = data[2].to_i
        map = Array.new(height){Array.new(width){0}}
        for i in 0...height do
            for j in 0...width do
                map[i][j] = map_data[i*width + j].to_i
            end
        end
        generation_number = data[3] 
        return map,generation_number
    end

    def self.load_parsed()
        return self.parse_data(self.load())
    end
end