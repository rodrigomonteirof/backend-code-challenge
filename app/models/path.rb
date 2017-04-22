class Path
  attr_reader :distances

  def initialize(distance = nil, path = nil)
    @distances = []
    @distances << path.distances if path.present?
    @distances << distance if distance.present?
    @distances.flatten!
  end

  def distance
    distances.map(&:kilometers).inject(:+)
  end

  def end
    distances.last.destination
  end
end
