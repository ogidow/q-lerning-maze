require './field.rb'

class QLerning
  def initialize
    @field = Field.new
    @n = 1000
    @q_value = Array.new(5){Array.new(5, {})}
  end

  def lean flag = false
    @state = {x: 0, y: 0}
    while true do
      actions = @field.actions @state
      action = choice_action actions, flag
      if flag
        @field.dump action.merge({q: @q_value[@state[:x]][@state[:y]][action]}), @state
      end
      update action
      break if action[:reward] == 50
    end
  end

  def solve
    lean true
  end

  def update action
    x = @state[:x]
    y = @state[:y]
    new_x = action[:x]
    new_y = action[:y]
    new_state = {x: new_x, y: new_y}

    best_action = select_best_action(new_state, @field.actions(new_state))
    @q_value[x][y][action] = @q_value[x][y][action].to_i +  0.2 * (action[:reward] + 0.9 * @q_value[new_x][new_y][best_action].to_i - @q_value[x][y][action].to_i)
    @state = new_state
  end

  def choice_action actions, flag
    if flag || 2 <= Random.rand(10)
      select_best_action @state, actions
    else
      actions.sample
    end
  end

  def select_best_action state, actions
    max_q = @q_value[state[:x]][state[:y]][actions.first].to_i
    action = actions.first
    actions.each do |a|
      if @q_value[state[:x]][state[:y]][a].to_i > max_q
        action = a
        max_q = @q_value[state[:x]][state[:y]][a].to_i
      end
    end
    action
  end
end
