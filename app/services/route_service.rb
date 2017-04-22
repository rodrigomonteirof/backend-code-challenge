class RouteService
  attr_reader :origin, :destination, :paths

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @paths = []
  end

  def find_shortest
    load_paths(origin) if @paths.blank?

    path = shortest_path

    return path if path.end == destination

    load_paths(path.end, path)

    remove_path(path)

    find_shortest
  end

  def load_paths(place, path = Path)
    Distance.where(origin: place).each do |distance|
      @paths << path.create_new(distance)
    end
  end

  def remove_path(path)
    @paths.delete(path)
  end

  def shortest_path
    @paths.sort_by(&:distance).first
  end
end
