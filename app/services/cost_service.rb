class CostService
  attr_reader :weight

  TAX = 0.15

  def initialize(weight)
    @weight = weight
  end

  def calculate(kilometers)
    kilometers * weight * TAX
  end
end
