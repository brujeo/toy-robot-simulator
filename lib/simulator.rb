# frozen_string_literal: true

# Toy Robot Simulator
class Simulator
  DIRECTIONS = {
    0 => 'WEST',
    90 => 'NORTH',
    180 => 'EAST',
    270 => 'SOUTH'
  }.freeze

  def initialize(dimensions_x = 5, dimensions_y = 5)
    @dimensions_x = dimensions_x
    @dimensions_y = dimensions_y
    @started = false
    @x = 0
    @y = 0
    @f = nil
  end

  # PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST
  def place(x, y, f)
    return unless validate_move(x, y)

    move_to(x, y)
    face_to(f)
    @started = true
  end

  # MOVE will move the toy robot one unit forward in the direction it is currently facing
  def move
    return unless @started

    case @f
    when 'WEST'
      next_x = @x - 1
      next_y = @y
    when 'NORTH'
      next_x = @x
      next_y = @y + 1
    when 'EAST'
      next_x = @x + 1
      next_y = @y
    when 'SOUTH'
      next_x = @x
      next_y = @y - 1
    end

    return unless validate_move(next_x, next_y)

    move_to(next_x, next_y)
  end

  # LEFT will rotate the robot 90 degrees in the specified direction without changing the position of the robot
  def left
    return unless @started

    rotate(-90)
  end

  # RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot
  def right
    return unless @started

    rotate(90)
  end

  # REPORT will announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient
  def report
    return unless @started

    puts "\t * " + @x.to_s + ',' + @y.to_s + ',' + @f
  end

  # validate move
  def validate_move(x, y)
    return false if x.negative? || x > (@dimensions_x - 1)
    return false if y.negative? || y > (@dimensions_y - 1)

    true
  end

  # move to specific position
  def move_to(x, y)
    @x = x
    @y = y
  end

  # face to specific direction
  def face_to(f)
    return unless DIRECTIONS.find { |_k, v| v == f }

    @f = f
  end

  # rotate by
  def rotate(degrees)
    curr_degrees = DIRECTIONS.find { |_k, v| v == @f }[0]
    new_degrees = curr_degrees + degrees
    new_degrees = 0 if new_degrees == 360
    new_degrees = 360 + new_degrees if new_degrees.negative?
    new_f = DIRECTIONS.find { |k, _v| k == new_degrees }[1]
    face_to(new_f)
  end

  def exec(command_string)
    puts ' > ' + command_string
    parts = command_string.split(' ')
    command = parts[0]
    args = parts[1].split(',') if parts[1]

    case command
    when 'PLACE'
      raise StandardError, 'Arguments not defined or incorrect' unless args && args.count == 3

      place(args[0].to_i, args[1].to_i, args[2])
    when 'MOVE'
      move
    when 'REPORT'
      report
    when 'LEFT'
      left
    when 'RIGHT'
      right
    else
      raise StandardError, 'Command not supported'
    end
  end
end
