class RouteService
  attr_reader :origin, :destination, :possibile_paths

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @possibile_paths = []
    load_paths(origin)
  end

  def find_shortest_path
    path = shortest_path

    return if path.blank?

    return path if path.end == destination

    load_paths(path.end, path)

    remove_path(path)

    find_shortest_path
  end

  private

  def load_paths(point, path = nil)
    Distance.where(origin: point).each do |distance|
      @possibile_paths << Path.new(distance, path)
    end
  end

  def remove_path(path)
    @possibile_paths.delete(path)
  end

  def shortest_path
    @possibile_paths.sort_by(&:distance).first
  end
end
