class MarsRover
  class << self
    # map direction to integers counterclockwise
    # so dealing with turning will be easier
    # turning right would be plus 1 to the direction
    # turning left would be minus 1
    def map_position(position)
      position = position.split(' ')
      case position[2]
      when 'N'
        position[2] = 0
      when 'E'
        position[2] = 1
      when 'S'
        position[2] = 2
      when 'W'
        position[2] = 3
      end
      [position[0].to_i, position[1].to_i, position[2]]
    end

    # map position back for string display in the end
    def reverse_map(position)
      case position[2]
      when 0
        position[2] = 'N'
      when 1
        position[2] = 'E'
      when 2
        position[2] = 'S'
      when 3
        position[2] = 'W'
      end
      position.join(' ')
    end

    # if the rover faces north, its y coordinate + 1
    # if east, x + 1; if south, y - 1; if west, x - 1
    # if the rover is at the edge, stays at the same spot
    def go_straight(position, coordinates)
      case position[2]
      when 0
        position[1] += 1 if position[1] + 1 <= coordinates[1]
      when 1
        position[0] += 1 if position[0] + 1 <= coordinates[0]
      when 2
        position[1] -= 1 if position[1] - 1 >= 0
      when 3
        position[0] -= 1 if position[0] - 1 >= 0
      end
      position
    end

    # check if it's turning left or right or moving forward
    def movement(character, position, coordinates)
      case character
      when 'L'
        # % 4 for mapping - 1 to 3
        position[2] = (position[2] - 1) % 4
      when 'R'
        # and mapping 4 to 0
        position[2] = (position[2] + 1) % 4
      when 'M'
        position = go_straight(position, coordinates)
      end
      position
    end

    # make the movement one character by one character
    def rover_movement(rover, coordinates)
      rover[1].chars.each do |m|
        rover[0] = movement(m, rover[0], coordinates)
      end
      rover[0]
    end

    def all_steps(rover, coordinates)
      MarsRover.reverse_map(MarsRover.rover_movement(rover, coordinates))
    end

    def get_input_from_file
      file_name = gets.strip
      input = Array.new
      File.open(file_name, 'r').each_line do |line|
        input << line.strip
      end

      coordinates = input[0].split(' ').map{ |i| i.to_i }
      rover_one = [MarsRover.map_position(input[1]), input[2]]
      rover_two = [MarsRover.map_position(input[3]), input[4]]

      rover_one_final = all_steps(rover_one, coordinates)
      rover_two_final = all_steps(rover_two, coordinates)

      puts rover_one_final.to_s
      puts rover_two_final.to_s
    end
  end
end
