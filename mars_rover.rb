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

def go_straight(position)
  case position[2]
  when 0
    position[1] += 1
  when 1
    position[0] += 1
  when 2
    position[1] -= 1
  when 3
    position[0] -= 1
  end
  position
end

def movement(character, position)
  case character
  when 'L'
    position[2] = (position[2] - 1) % 4
  when 'R'
    position[2] = (position[2] + 1) % 4
  when 'M'
    position = go_straight(position)
  end
  position
end

def rover_movement(rover)
  rover[1].split('').each do |m|
    rover[0] = movement(m, rover[0])
  end
  rover[0]
end

file_name = 'test_input.txt'#gets.strip

puts file_name

input = Array.new

File.open(file_name, 'r').each_line do |line|
  input << line.strip
end

coordinates = input[0]
rover_one = [map_position(input[1]), input[2]]
rover_two = [map_position(input[3]), input[4]]

rover_one_final = reverse_map(rover_movement(rover_one))
rover_two_final = reverse_map(rover_movement(rover_two))

puts input.to_s
puts coordinates
puts rover_one.to_s
puts rover_two.to_s
puts rover_one_final.to_s
puts rover_two_final.to_s


