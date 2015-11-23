require "./q_learning_maze.rb"

l = QLerning.new
5000.times do |i|
    l.lean
end
l.solve
