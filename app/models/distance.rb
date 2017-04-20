class Distance < ActiveRecord::Base
  validates :kilometers, inclusion: { in: 1..100_000 }
  validates :origin, presence: true
  validates :destiny, presence: true

  def self.find_or_create(origin, destiny)
    Distance.find_or_create_by(origin: origin, destiny: destiny)
  end
end
