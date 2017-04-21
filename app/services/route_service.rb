class RouteService
  attr_reader :origin, :destination, :paths

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @paths = []
  end

  def distances_from(place)
    Distance.where(origin: place)
  end

  def remove_path(path)
    @paths.delete(path)
  end

  def shortest_path
    @paths.sort_by(&:distance).first
  end
end
