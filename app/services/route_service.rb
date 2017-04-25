class RouteService
  attr_reader :origin, :destination, :paths

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @paths = []
    load_paths(origin)
  end

  def find_shortest
    path = shortest_path

    return if path.blank?

    return path if path.end == destination

    load_paths(path.end, path)

    remove_path(path)

    find_shortest
  end

  private

  def load_paths(point, path = nil)
    Distance.where(origin: point).each do |distance|
      @paths << Path.new(distance, path)
    end
  end

  def remove_path(path)
    @paths.delete(path)
  end

  def shortest_path
    @paths.sort_by(&:distance).first
  end
end
