class CostService
  attr :kilometers

  TAX = 0.15

  def initialize(kilometers)
    @kilometers = kilometers
  end

  def calculate(weight)
    @kilometers * weight * TAX
  end
end
