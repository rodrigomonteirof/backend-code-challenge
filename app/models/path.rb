class Path
  attr_reader :distances

  def initialize
    @distances = []
  end

  def distance
    distances.map(&:kilometers).inject(:+)
  end

  def create_new(distance)
    path = Path.new
    path.distances << @distances
    path.distances << distance
    path.distances.flatten!
    path
  end
end
