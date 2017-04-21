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

  def find_shortest
    distances = distances_from(origin)

    distances.each do |distance|
      path = Path.new
      path.distances << distance
      @paths << path
    end

    dijkstra_recursivity
  end

  def dijkstra_recursivity
    path = shortest_path

    return path if path.end == destination

    distances = distances_from(path.end)

    distances.each do |distance|
      @paths << path.create_new(distance)
    end

    remove_path(path)

    dijkstra_recursivity
  end

  def remove_path(path)
    @paths.delete(path)
  end

  def shortest_path
    @paths.sort_by(&:distance).first
  end
end
