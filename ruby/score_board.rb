class ScoreBoard
  attr_accessor :scores

  def initialize
    @scores = Hash.new(0)
  end

  def add(name, point)
    @scores[name] += point
  end

  def total(name)
    @scores[name]
  end

  def ranking
    @scores.to_a.sort_by { |score| -score[1] }
  end
end

sb = ScoreBoard.new
sb.add("Alice", 3)

sb = ScoreBoard.new
sb.add("Alice", 7)

p sb.total("Alice")
