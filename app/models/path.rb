class Path
  attr_reader :distances

  def initialize
    @distances = []
  end

  def self.create_new(distance)
    new.tap do |path|
      path.distances << distance
    end
  end

  def create_new(distance)
    Path.new.tap do |path|
      path.distances << @distances
      path.distances << distance
      path.distances.flatten!
    end
  end

  def distance
    distances.map(&:kilometers).inject(:+)
  end

  def end
    distances.last.destination
  end
end
