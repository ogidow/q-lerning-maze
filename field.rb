=begin
#####################
#S   0   0    0    0#
#0 -10   0    0    0#
#0   0 -10    0  -10#
#0 -10   0    0    0#
#0   0   0  -10   50#
#####################
=end

class Field
  def initialize
    @field = Array.new(5){Array.new(5, 0)}
    @field[1][1] = @field[1][3] = @field[2][2] = @field[3][4] = @field[4][2] = -10
    @field[4][4] = 50
    @size = 5
  end

  def dump(action, state = {})
    puts "x: #{state[:x]} y: #{state[:y]}"

    @size.times do |y|
      @size.times do |x|
        if state[:x] == x && state[:y] == y
          print "%4s"%"@"
        else
          print "%4d"%(@field[x][y])
        end
      end
      puts ""
    end
    puts ""
  end

  def actions state
    a_list = []
    a_list << generate_action(state, 0, 1) if range? state, 0, 1
    a_list << generate_action(state, 1, 0) if range? state, 1, 0
    a_list << generate_action(state, 0, -1) if range? state, 0, -1
    a_list << generate_action(state, -1, 0) if range? state, -1, 0
    a_list
  end

  def generate_action state, x, y
    new_x = state[:x] + x
    new_y = state[:y] + y
    {x: new_x, y: new_y, reward: @field[new_x][new_y]}
  end
  def range? state, x, y
    new_x = state[:x] + x
    new_y = state[:y] + y
    0 <= new_x && new_x < 5 && 0 <= new_y && new_y < 5
  end
end
