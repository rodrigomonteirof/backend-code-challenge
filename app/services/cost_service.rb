class CostService
 include ActiveModel::Validations

  attr_reader :weight

  validates :weight, inclusion: { in: 1..50 }

  TAX = 0.15

  def initialize(weight)
    @weight = weight
  end

  def calculate(kilometers)
    kilometers * weight * TAX
  end
end
