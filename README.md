# yroo-programming-exercise

## To run application
* run `ruby -r ./mars_rover.rb -e 'MarsRover.get_input_from_file'`
* input file name e.g. `test_input.txt`

## To run test
* run `ruby tests.rb` at terminal command line

## Major design decisions and assumptions
* Convert the strings of directions to integers, so it can work like a clock
* Assume that the rovers will not go off grid and they will only be deployed one at a time
