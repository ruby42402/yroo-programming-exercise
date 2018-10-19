require_relative 'mars_rover.rb'
require 'minitest/autorun'
class Test < Minitest::Test
  def setup
    @grid = [5, 5]
    @n_s, @n_a = '1 1 N', [1, 1, 0]
    @e_s, @e_a = '2 2 E', [2, 2, 1]
    @s_s, @s_a = '3 3 S', [3, 3, 2]
    @w_s, @w_a = '4 4 W', [4, 4, 3]
  end

  def test_forward_map
    assert_equal @n_a, MarsRover.map_position(@n_s)
    assert_equal @e_a, MarsRover.map_position(@e_s)
    assert_equal @s_a, MarsRover.map_position(@s_s)
    assert_equal @w_a, MarsRover.map_position(@w_s)
  end

  def test_backward_map
    assert_equal @n_s, MarsRover.reverse_map(@n_a)
    assert_equal @e_s, MarsRover.reverse_map(@e_a)
    assert_equal @s_s, MarsRover.reverse_map(@s_a)
    assert_equal @w_s, MarsRover.reverse_map(@w_a)
  end

  def test_move_forward
    assert_equal [1, 2, 0], MarsRover.go_straight(@n_a, @grid)
    assert_equal [3, 2, 1], MarsRover.go_straight(@e_a, @grid)
    assert_equal [3, 2, 2], MarsRover.go_straight(@s_a, @grid)
    assert_equal [3, 4, 3], MarsRover.go_straight(@w_a, @grid)
  end

  def test_move_forward_through_movement
    assert_equal [1, 2, 0], MarsRover.movement('M', @n_a, @grid)
    assert_equal [3, 2, 1], MarsRover.movement('M', @e_a, @grid)
    assert_equal [3, 2, 2], MarsRover.movement('M', @s_a, @grid)
    assert_equal [3, 4, 3], MarsRover.movement('M', @w_a, @grid)
  end

  def test_left_turn
    assert_equal [1, 1, 3], MarsRover.movement('L', @n_a, @grid)
    assert_equal [2, 2, 0], MarsRover.movement('L', @e_a, @grid)
    assert_equal [3, 3, 1], MarsRover.movement('L', @s_a, @grid)
    assert_equal [4, 4, 2], MarsRover.movement('L', @w_a, @grid)
  end

  def test_right_turn
    assert_equal [1, 1, 1], MarsRover.movement('R', @n_a, @grid)
    assert_equal [2, 2, 2], MarsRover.movement('R', @e_a, @grid)
    assert_equal [3, 3, 3], MarsRover.movement('R', @s_a, @grid)
    assert_equal [4, 4, 0], MarsRover.movement('R', @w_a, @grid)
  end

  def test_movement_sequence
    assert_equal [2, 2, 1], MarsRover.rover_movement([@n_a, 'MRM'], @grid)
    assert_equal [3, 3, 0], MarsRover.rover_movement([@e_a, 'MLM'], @grid)
    assert_equal [4, 2, 1], MarsRover.rover_movement([@s_a, 'MLM'], @grid)
    assert_equal [3, 3, 2], MarsRover.rover_movement([@w_a, 'MLM'], @grid)
  end

  def test_stay_within_the_grid
    assert_equal [1, 5, 0], MarsRover.rover_movement([@n_a, 'MMMMMMM'], @grid)
    assert_equal [5, 2, 1], MarsRover.rover_movement([@e_a, 'MMMMMMM'], @grid)
    assert_equal [3, 0, 2], MarsRover.rover_movement([@s_a, 'MMMMMMM'], @grid)
    assert_equal [0, 4, 3], MarsRover.rover_movement([@w_a, 'MMMMMMM'], @grid)
  end

  def test_sample_one
    position_array = MarsRover.map_position('1 2 N')
    assert_equal [1, 2, 0], position_array
    assert_equal '1 3 N', MarsRover.all_steps([position_array, 'LMLMLMLMM'], @grid)
  end

  def test_sample_two
    position_array = MarsRover.map_position('3 3 E')
    assert_equal [3, 3, 1], position_array
    assert_equal '5 1 E', MarsRover.all_steps([position_array, 'MMRMMRMRRM'], @grid)
  end
end
